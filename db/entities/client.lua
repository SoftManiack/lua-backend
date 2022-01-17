local entity = require('data-mapper.entity')
local db = require("db.connect")

local client = entity:new{
    table = 'client',
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
        email = {
            type = 'string'
        },
        name = {
            type = 'string'
        },
        phone = {
            type = 'string'
        },
        tsform = {
            type = 'string'
        },
        tsto = {
            type = 'string'
        },
    }
}

return client