return {
    server_options = {
        log_requests = true,
        log_errors   = true
    },
    -- this is an example, remove if not needed, also delete an option in app.lua and prometheus dependency
    metrics = {
        path = "/metrics",
        prefix = "prometheus_test", -- will be prepended to the name of each collection
        collect = {
            --[[
                gauge setting with a call option will actually be a background process(fiber)
                that wakes up every [step] seconds and sets a new value to the collection
            ]]
            {
                name = "mem_usage",
                description = "Instance's memory usage",
                type = "gauge",
                call = _G.gcinfo, -- this function will be called to get the value
                step = 5 -- in seconds, default value is 15
            },
            -- simple counting, incremented on all matches of the watch value
            {
                name = "request_count",
                description = "Count all processed requests",
                watch = "/*path", -- shall watch all the requests
                method = "GET" -- to match all, just set ANY or don't set at all
            }
        }
    }
}
