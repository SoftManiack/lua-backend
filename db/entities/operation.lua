local entity = require('data-mapper.entity')
local db = require("db.connect")

local operation = entity:new{
    table = 'operation',
    pk = 'uid',
    db = db,
    fields = {
        uid = {
            type = 'string'
        },
        uid_balance = {
            alias ='balance',
            type = 'string',
            foreign_key = true,
            table = require("db.entities.balance")
        },
        sid = {
            alias ='operation_type',
            type = 'string',
            foreign_key = true,
            table = require("db.entities.operation_type")
        },
        tsform = {
            type = 'string'
        },
        amount = {
            type = 'string'
        },
        uid_tariff = {
            alias ='tariff',
            type = 'string',
            foreign_key = true,
            table = require("db.entities.tariff")
        },
    }
}

return operation