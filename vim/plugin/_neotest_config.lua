neotest = require('neotest')

-- https://github.com/marilari88/neotest-vitest/issues
vitest = require('neotest-vitest')
vitest['filter_dir'] = function(name)
  return (name ~= 'node_modules' and name ~= 'tests' and name ~= '.tests' and name ~= 'coverage')
end
vitest.is_test_file = function(file_path)
  return file_path:match('test.ts')
end

-- https://github.com/nvim-neotest/neotest
-- https://github.com/nvim-neotest/neotest/blob/master/lua/neotest/config/init.lua#L131
neotest.setup({
  output_panel = {
    enabled = true,
    open = 'botright vsplit | vertical resize 60 | set winfixwidth',
  },
  summary = {
    animated = true,
    enabled = true,
    expand_errors = true,
    follow = true,
    mappings = {
      attach = 'a',
      clear_marked = 'M',
      clear_target = 'T',
      debug = 'd',
      debug_marked = 'D',
      expand = { '<CR>', '<2-LeftMouse>' },
      expand_all = 'e',
      jumpto = 'i',
      mark = 'm',
      next_failed = 'J',
      output = 'o',
      prev_failed = 'K',
      run = 'r',
      run_marked = 'R',
      short = 'O',
      stop = 'u',
      target = 't',
    },
    open = 'botright vsplit | vertical resize 40 | set winfixwidth',
  },
  quickfix = {
    enabled = true,
    open = false,
  },
  adapters = {
    -- require('neotest-plenary').setup({
    --   min_init = '/etc/nixos/vim/spec/test_init.lua',
    -- }),
    -- https://github.com/thenbe/neotest-playwright#configuration
    require('neotest-playwright').adapter({
      options = {
        persist_project_selection = false,
        enable_dynamic_test_discovery = false,
        -- preset = 'headed',
      },
    }),
    vitest,
  },
  consumers = {
    playwright = require('neotest-playwright.consumers').consumers,
  },
})
