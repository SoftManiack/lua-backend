local dm = require('data-mapper')

local config = {
        driver = "tarantool-pg",
        host = "localhost",
        port = "5432",
        username = "postgres",
        password = "Pa$$w0rd",
        database = "test",
        size = 2
}

local db = dm.db:new({config = config})

return db