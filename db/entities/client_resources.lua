local entity = require('data-mapper.entity')
local db = require("db.connect")

local client_resources = entity:new{
    table = 'client_resources',
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

return client_resources