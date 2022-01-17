#!/usr/bin/env tarantool
--sudo nginx -p `pwd`/ -c nginx_dev.conf

local openapi   = require("gtn.openapi")

local security = require("modules.security")

local app = openapi(
    require("http.server"),
    require("http.router"),
    "routing.yaml",
    {
        security = security,
        cors     = {
            max_age = 3600,
            -- default {"Authorization", "Content-Type"}
            allow_headers = { "*" },
            -- default {"*"}
            allow_origin = { "*" }
        },
        metrics  = app_config.metrics
    }
)

local app_router = app:router()

-- simple route to render index template by
app_router:route({
    path = "/",
    file = "index.html"
})

-- override default error responses
app:default(
    function(self, err)
        return self:render({
            status = 204,
            json = {
                success = false,
                error   = err
            }
        })
    end
)

-- override request validation errors response
app:error_handler(
    function(self, err)
        return self:render({
            json = {
                success = false,
                error   = err
            }
        })
    end
)

-- override security errors response
app:security_error_handler(
    function(self, err)
        return self:render({
            status = 401,
            json = {
                error = err
            }
        })
    end
)

app:start()
