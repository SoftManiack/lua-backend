local _M = {}

local orm = require("db.orm")

function _M.get_profile(self)

    local client_id = self.authorization[1].client

    local client, err = orm.client:get_by_pk(client_id)

    if err then
        return self:render( {json = { error = true, message = "Failed to get client"}})
    end

    local tariff, err = orm.tariff:get_by_pk(client.tariff)

    if err then
        return self:render( {json = {error = true, message = "Failed to get tariff for client"}})
    end

    local balance, err = orm.balance:get_by_field('uid_client', client_id)[1]

    if err then
        return self:render( {json = { error = true, message = "Failed to add client"}})
    end

    local tariff_resources, err = orm.tariff_resources:get_by_field('uid_tariff', client.tariff)[1]

    if err then
        return self:render( {json = { error = true, message = "Failed to get tariff resources"}})
    end

    local client_resources = orm.client_resources:get_by_field('uid_client', client_id)[1]

    if err then
        return self:render( {json = { error = true, message = "Failed to add client"}})
    end

    local data = {
        client = {
            name = client.name,
            email = client.email,
            phone = client.phone,
            tsto = client.tsto
        },
        tariff = {
            name = tariff.name,
            price = tariff.price,
            day = tariff.days,
            uid = tariff.uid
        },
        balance = {
            balance = balance.balance
        },
        tariffResources = {
            internet = tariff_resources.internet,
            calls = tariff_resources.calls,
            sms = tariff_resources.sms
        },
        clientResources = {
            internet = client_resources.internet,
            calls = client_resources.calls,
            sms = client_resources.sms
        }
    }

    return self:render({ json = { success = true, data = data } })

end

return _M