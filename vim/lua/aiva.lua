local naughty = require('naughty')

local aiva = {}

function aiva.greet()
  naughty.notify({
    title = 'Hello! ' .. os.time() .. 'and we are so cool',
    message = 'We are happy to greet you',
    timeout = 10,
  })
end

return aiva
