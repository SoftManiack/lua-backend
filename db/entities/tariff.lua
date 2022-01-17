local entity = require('data-mapper.entity')
local db = require("db.connect")

local tariff = entity:new{
    table = 'tariff',
    pk = 'uid',
    db = db,
    fields = {
        uid = {
            type = 'string'
        },
        name = {
            type = 'string'
        },
        price = {
            type = 'string'
        },
        days = {
            type = 'number'
        },
    }
}

return tariff