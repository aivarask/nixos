-- https://github.com/marilari88/neotest-vitest/issues
local adapter = require('neotest-vitest')

adapter['filter_dir'] = function(name)
  local excl = { 'packages' }
  return (
    name ~= 'packages'
    and name ~= 'node_modules'
    and name ~= 'tests'
    and name ~= '.tests'
    and name ~= 'coverage'
    and name ~= 'dist'
  )
end

adapter.is_test_file = function(file_path)
  return file_path:match('test.js')
end

vitest = adapter
