local entity = require('data-mapper.entity')
local db = require("db.connect")

local balance = entity:new{
    table = 'balance',
    pk = 'uid',
    db = db,
    fields = {
        uid = {
            type = 'string'
        },
        uid_client = {
            alias ='client',
            type = 'string',
            foreign_key = true,
            table = require("db.entities.client")
        },
        tsform = {
            type = 'string'
        },
        tsto = {
            type = 'string'
        },
        balance = {
            type = 'number'
        },
    }
}

return balance