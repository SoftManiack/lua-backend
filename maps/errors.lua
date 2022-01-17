local errors = {
    NOT_FOUND = {
        result =false,
        error = "Not found",
        code = 404
    },
    BAD_REQUEST = {
        result = false,
        error  = "Bad request",
        code = 400
    },
    FORBIDDEN   = {
        result = false,
        error  = "Forbidden",
        code   = 403
    },
    INSUFFICIENT_FUNDS = {
        result = false,
        error  = "Insufficient funds",
        code   = 422
    },
    INVALID_PARAMETERS = {
        result = false,
        error  = "Invalid Parameters",
        code   = 422
    },
    DENIED = {
        result = false,
        error = "Access Denied",
        code = 403.1
    },
    DATABASE_ERROR = {
        result = false,
        error = "Database Error",
        code = 500
    },
    INVALID_DATA = {
        result = false,
        error = "Invalid Data",
        code = 500
    }
}

return errors
