local entity = require('data-mapper.entity')
local db = require("db.connect")

local operation_type = entity:new{
    table = 'operation_type',
    pk = 'sid',
    db = db,
    fields = {
        uid = {
            type = 'string'
        },
        name = {
            type = 'string'
        },
    }
}

return operation_type