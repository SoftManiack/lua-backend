local tap = require("tap")

local test = tap.test("after tests")
test:plan(1)
test:ok(true, "AFTER OK")