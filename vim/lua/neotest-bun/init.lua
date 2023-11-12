-- https://github.com/nvim-neotest/neotest#neotest
-- https://github.com/nvim-neotest/neotest#writing-adapters
-- https://github.com/nvim-neotest/neotest/blob/master/lua/neotest/adapters/interface.lua
-- https://github.com/nvim-neotest/neotest-plenary
-- https://github.com/nvim-neotest/neotest-jest
-- https://github.com/marilari88/neotest-vitest
-- print('Hello from neotest-bun')

---@type neotest.Adapter
local adapter = {
  name = 'neotest-bun',
  root = function(dir)
    return vim.uv.cwd()
  end,
  filter_dir = function(name, rel_path, root)
    return name ~= 'node_modules'
  end,
  is_test_file = function(file_path)
    return file_path:match('math.test.js')
  end,
}

return adapter
