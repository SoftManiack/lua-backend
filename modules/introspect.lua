local http_client = require("http.client").new({5})
local json        = require("json")
local url         = require("net.url") -- хорошая библиотека для формирования URL и тела запросов

local function introspect(token)

    local client_info = http_client:post(
            "https://id.gtn.ee/oauth/introspect",
            url.buildQuery({token = token}),
            {
                headers = {
                    ['Authorization'] = ("Bearer %s"):format(token),
                    ['Content-Type']  = "application/x-www-form-urlencoded"
                }
            }
    )

    local status, decoded = pcall(json.decode, client_info.body)

    if not status then
        return nil, "Invalid JSON data"
    end

    return decoded
end

return introspect
