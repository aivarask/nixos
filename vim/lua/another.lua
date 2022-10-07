local mymath = require "aiva.mymath"
local reload = require "plenary.reload"
local res = mymath.add(1, 2)
print(res)

reload.reload_module('aiva')
require('aiva').greetter()
