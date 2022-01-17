local _M = {}
local errors =  require('maps.errors')
local db = require("db.connect")
local orm = require("db.orm")

function _M.get_tariffs(self)

    local tariffs, err = db:query(
            [[
                SELECT t.uid, t.name, t.days, t.price, internet, sms, calls
                    FROM tariff AS t
                    JOIN tariff_resources AS r
                        ON r.uid_tariff = t.uid;
            ]]
    )

    if err then
        return self:render({ json = errors.DATABASE_ERROR })
    end

    return self:render({ status = 200, json = { success = true, data = tariffs } })

end

function _M.update_user_tariff(self)

    local body = self:json()

    local client_id = self.authorization[1].client

    local client_balance, err = orm.balance:get_by_field('uid_client', client_id)[1]

    if err then
        return self:render( {json = {error = true, message = "Failed to get tariff of client"}})
    end

    local new_tariff, err = orm.tariff:get_by_pk(body.uid)

    if err then
        return self:render({ status = 422, json = errors.INVALID_PARAMETERS })
    end

    if client_balance.balance <= new_tariff.price then
        return self:render({ status = 422, json = errors.INSUFFICIENT_FUNDS })
    end

    local new_balance = client_balance.balance - new_tariff.price

    local query = string.format(
            [[
            BEGIN;
                UPDATE client SET uid_tariff = '%s'
                    WHERE uid = '%s';
                UPDATE balance SET balance = %s
                    WHERE uid_client = '%s';
                INSERT INTO operation (uid_balance, sid, amount, uid_tariff) VALUES
                        ('%s', 'write-downs', %s, '%s');
            COMMIT;
    ]], new_tariff.uid, client_id, new_balance, client_id, client_balance.uid, new_tariff.price, new_tariff.uid )

    local _, err = db:query(query)

    if err then
        return self:render( {json = { error = true, message = "Failed to get tariff" } })
    end

    local balance, err = orm.balance:get_by_field('uid_client', client_id)[1]

    if err then
        return self:render( { json = { error = true, message = "Failed to get balance" } })
    end

    return self:render({ status = 200, json = { success = true, data = balance.balance } })

end

return _M