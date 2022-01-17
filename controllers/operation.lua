local _M = {}
local errors =  require('maps.errors')
local db = require("db.connect")
local orm = require("db.orm")

function _M.get_operations(self)

    local client_id = self.authorization[1].client

    local balance, err = orm.balance:get_by_field('uid_client', client_id)[1]

    if err then
        return self:render( {json = { error = true, message = "Failed to get balance of client" } })
    end

    local query = string.format([[
        SELECT o.amount, o.tsform, t.name FROM operation AS o
            JOIN operation_type AS t
            ON t.sid = o.sid AND o.uid_balance = '%s';
    ]], balance.uid)

    local operation, err = db:query(query)

    if err then
        return self:render({ json = { error = true, message = "Failed to get operations" } })
    end

    if operation then
        return self:render({ status = 200, json = { success = true, data = operation } })
    end

    return self:render({ status = 422, json = errors.DATABASE_ERROR })

end

function _M.pay_operation(self)

    local body = self:json()
    local client_id = self.authorization[1].client

    if( type(body.amount) ~= "number" or body.amount < 100 or body.amount > 10000) then
        return self:render({ status = 422, json = errors.INVALID_PARAMETERS })
    end

    local balance, err = orm.balance:get_by_field('uid_client', client_id)[1]

    if err then
        return self:render({ json = { error = true, message = "Failed to get balance to client"}})
    end

    local client, err = orm.client:get_by_pk(client_id)

    if err then
        return self:render({ json = { error = true, message = "Failed to get client "}})
    end

    local query = string.format(
            [[
            BEGIN;
                INSERT INTO operation (uid_balance, sid, amount, uid_tariff) VALUES
                    ('%s', 'top-up', '%s', '%s');
                UPDATE balance
                    SET balance =
                        ( SELECT SUM(amount) FROM operation WHERE uid_balance = '%s')
                    WHERE uid_client = '%s';
            COMMIT;
    ]], balance.uid, body.amount, client.tariff, balance.uid, client_id )

    db:query(query)

    return self:render({ status = 200, json = { success = true } })

end

return _M