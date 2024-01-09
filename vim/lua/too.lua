-- TESTING runtime/library
local function test_custom_paths()
  require('hoo').hi()
  require('voo').hi()
  require('loo').hi()
  require('poo').hi()
end

local function test_system_wide()
  require('luassert')
  require('busted')
  -- require('lfs') -- probably obsolete in vim scope
  require('luv')
  require('pl')
  require('luacheck')
  require('std._debug')(false) -- https://lua-stdlib.github.io/_debug/
  require('std._debug.version')
  require('inspect')
end

return {
  custom = test_custom_paths,
  system = test_system_wide
}
