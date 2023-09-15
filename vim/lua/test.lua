-- widgets = require('vicious.widgets.init')
-- print(widgets.volume(nil, 'Master')[1])

--- @param arg string
function foo(arg)
  local person = { name = 'Tom', age = 25 }
  print(arg)
  print(person.name)
end
print('Hello')

local arg = '22'
foo(arg)
