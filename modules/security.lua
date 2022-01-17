local _M = {}
local introspect = require("modules.introspect")
local inspect = require 'inspect'

local db = require("db.connect")
local orm = require("db.orm")

function _M.bearerAuth(url, scope, token)

    local granted = false

    local token_data = orm.token:get{ access = token }

    if next(token_data) then
        granted = true
    else

        local client_info = introspect(token)

        if client_info then
            if client_info.active then

                local exists_client = orm.client:get_by_pk(client_info.client_id)

                if exists_client then
                    orm.token:update({ access = token }, { uid_client = client_info.client_id })
                    granted = true
                else

                    local tariff_default, err = db:query(
                            [[
                                SELECT uid
                                    FROM tariff
                                    WHERE price = ( SELECT min(price) FROM tariff);
                            ]]
                    )

                    if err then
                        return self:render({json = {error = true, message = "Failed to update tariff"}})
                    end

                    local email = "неуказана почта"
                    local first_name = " "
                    local last_name = " "
                    local phone = "неуказан телефон"

                    if client_info.counterparty.detail[1].data.email ~= nil then
                        email = client_info.counterparty.detail[1].data.email
                    end
                    if client_info.counterparty.detail[1].data.phone ~= nil then
                        phone = client_info.counterparty.detail[1].data.phone
                    end
                    if client_info.counterparty.detail[2].data.first_name ~= nil then
                        first_name = client_info.counterparty.detail[2].data.first_name
                    end
                    if client_info.counterparty.detail[2].data.last_name ~= nil then
                        last_name = client_info.counterparty.detail[2].data.last_name
                    end

                    local client, err = orm.client:add({
                        uid = client_info.client_id,
                        uid_tariff = tariff_default[1].uid,
                        email = email,
                        name = ("%s %s"):format(first_name , last_name),
                        phone = phone
                    })

                    if err then
                        return self:render({json = {error = true, message = "Failed to add client"}})
                    end

                    local new_token, err = orm.token:add({
                        access = token,
                        expires_in = 1,
                        uid_client = client_info.client_id
                    })

                    if err then
                        return self:render({json = {error = true, message = "Failed to add token"}})
                    end

                    token_data = new_token

                    local balance, err = orm.balance:add({
                        uid_client = client_info.client_id,
                        balance = 0
                    })

                    if err then
                        return self:render({json = {error = true, message = "Failed to add balance"}})
                    end

                    local resources, err = orm.client_resources:add({
                        uid_client = client_info.client_id,
                        internet = 8004,
                        sms = 5,
                        calls = 24,
                    })

                    if err then
                        return self:render({json = {error = true, message = "Failed to add resources"}})
                    end

                    if next(client) and next(tariff_default) and next(balance) and next(resources) then
                        granted = true
                    end

                end
            end
        else
            granted = false
        end
    end

    if not granted then
        return nil, "Authentication Failure"
    end

    token_data = orm.token:get{ access = token }
    return token_data

end

function _M.basicAuth(url, scope, username, password)
    if username == "johndoe" and password == "swordfish" then
        return {}
    end

    return nil, "Unauthorized"
end

function _M.cookieAuth(url, scope, key)
    if key == "testing" then
       return {}
    end

    return nil, "Unauthorized"
end

return _M
