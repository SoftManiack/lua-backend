local _M = {}

function _M.bearer(self)
    return self:render({
        json = {
            success = true,
            data    = "bearer data"
        }
    })
end

function _M.basic(self)
    return self:render({
        json = {
            success = true,
            data    = "basic data"
        }
    })
end

function _M.cookie(self)
    return self:render({
        json = {
            success = true,
            data    = "cookie data"
        }
    })
end

return _M
