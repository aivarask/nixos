-- https://github.com/marilari88/neotest-vitest/issues
vitest = require('neotest-vitest')
vitest['filter_dir'] = function(name)
  return (name ~= 'node_modules' and name ~= 'tests' and name ~= '.tests' and name ~= 'coverage')
end
vitest.is_test_file = function(file_path)
  return file_path:match('test.ts')
end
