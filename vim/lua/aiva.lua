local naughty = require('naughty')

local aiva = {}

--- Simple greet function.
--- @param foo ?string
-- @return None.
function aiva.greet(foo)
  if foo then
    print(foo)
  end
  naughty.notify({
    title = 'Hello! ' .. os.time() .. 'and we are so cool',
    message = 'We are happy to greet you',
    timeout = 10,
    position = 'bottom_right',
  })
end

--- Get notification by ID
--
-- @param id ID of the notification
-- @return notification object if it was found, nil otherwise
function aiva.foo(id)
  print(id)
end

return aiva
