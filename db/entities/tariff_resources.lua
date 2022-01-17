local entity = require('data-mapper.entity')
local db = require("db.connect")

local tariff_resources = entity:new{
    table = 'tariff_resources',
    pk = 'uid',
    db = db,
    fields = {
        uid = {
            type = 'string'
        },
        uid_tariff = {
            alias ='tariff',
            type = 'string',
            foreign_key = true,
            table = require("db.entities.tariff")
        },
        internet = {
            type = 'number'
        },
        sms = {
            type = 'number'
        },
        calls = {
            type = 'number'
        },
    }
}

return tariff_resources