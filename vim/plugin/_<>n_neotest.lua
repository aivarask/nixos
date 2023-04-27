local neotest = require('neotest')

-- https://github.com/nvim-neotest/neotest
-- https://github.com/nvim-neotest/neotest/blob/master/lua/neotest/config/init.lua#L131
require('neotest').setup({
  output_panel = {
    enabled = true,
    open = 'botright vsplit | vertical resize 60 | set winfixwidth',
  },
  summary = {
    open = 'botright vsplit | vertical resize 40 | set winfixwidth',
  },
  quickfix = {
    enabled = true,
    open = false,
  },
  adapters = {
    -- require('neotest-plenary').setup({
    --   -- https://github.com/nvim-neotest/neotest-plenary
    --   min_init = '/etc/nixos/vim/spec/test_init.lua',
    -- }),
    -- require('neotest-vitest'),
    -- https://github.com/thenbe/neotest-playwright#configuration-1
    require('neotest-playwright').adapter({
      options = {
        persist_project_selection = false,

        enable_dynamic_test_discovery = false,

        preset = 'none', -- "none" | "headed" | "debug"

        -- get_playwright_binary = function()
        --    return vim.loop.cwd() + "/node_modules/.bin/playwright"
        -- end,

        -- get_playwright_config = function()
        --    return vim.loop.cwd() + "/playwright.config.ts"
        -- end,

        -- get_cwd = function()
        --    return vim.loop.cwd()
        -- end,

        -- env = { },

        -- Extra args to always pass to playwright.
        -- These are merged with any extra_arg passed
        -- to neotest's run command.
        -- extra_args = { },

        -- Filter directories when searching for test files,
        -- useful in large projects (see performance notes).
        filter_dir = function(name, rel_path, root)
          print(name)
          return name ~= 'src'
        end,
      },
    }),
  },
})

neotest.run.buffer = function()
  neotest.run.run(vim.fn.expand('%'))
end

neotest.run.suite = function()
  neotest.run.run({ suite = true })
end

neotest.run.dap = function()
  neotest.run.run({ strategy = 'dap' })
end

wkr({
  name = 'Neotest',
  r = { neotest.run.run, 'run' },
  a = { neotest.run.attach, 'attach' },
  l = { neotest.run.run_last, 'run_last' },
  -- s = { neotest.run.stop, 'stop' },
  s = { neotest.summary.toggle, 'summary' },
  o = { neotest.output_panel.toggle, 'output_panel' },
  S = { neotest.run.suite, 'suite' },
  b = { neotest.run.buffer, 'buffer' },
  d = { neotest.run.dap, 'dap' },
  c = { [[:!busted<cr>]], '!busted' },
}, { prefix = '<leader>n' })
wkr({
  ['<leader>]'] = { require('neotest').summary.toggle, 'summary' },
  ['<leader>}'] = { require('neotest').output_panel.toggle, 'output_panel' },
})
