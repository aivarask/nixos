local neotest = require('neotest')

-- https://github.com/nvim-neotest/neotest
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
    -- https://github.com/nvim-neotest/neotest/blob/master/lua/neotest/config/init.lua#L131
    require('neotest-vitest'),
    require('neotest-playwright').adapter({}),
    -- https://github.com/nvim-neotest/neotest-plenary
    -- https://github.com/nvim-lua/plenary.nvim
    -- https://github.com/lunarmodules/busted
    require('neotest-plenary').setup({
      min_init = '/etc/nixos/vim/spec/test_init.lua',
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
