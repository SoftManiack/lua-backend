local tap = require("tap")

local test = tap.test("before tests")
test:plan(1)
test:ok(true, "BEFORE OK")