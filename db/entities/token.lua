local entity = require('data-mapper.entity')
local db = require("db.connect")

local token = entity:new{
    table = 'token',
    pk = 'access',
    db = db,
    fields = {
        access = {
            type = 'string'
        },
        tscreate = {
            type = 'string'
        },
        expires_in = {
            type = 'number'
        },
        tsupdate = {
            type = 'string'
        },
        uid_client = {
            alias = 'client',
            type = 'string',
            foreign_key = true,
            table = require("db.entities.client")
        }
    }
}

return token
