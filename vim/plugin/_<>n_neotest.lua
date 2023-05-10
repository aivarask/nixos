---@diagnostic disable: duplicate-set-field
local neotest = require('neotest')

local vitestAdapter = require('neotest-vitest')
vitestAdapter['filter_dir'] = function(name)
  return (name ~= 'node_modules' and name ~= 'tests' and name ~= '.tests' and name ~= 'coverage')
end
vitestAdapter.is_test_file = function(file_path)
  return file_path:match('test.ts')
end

local playwrightAdapter = require('neotest-playwright').adapter({})
playwrightAdapter.filter_dir = function(name)
  return (name ~= 'node_modules' and name ~= 'src' and name ~= '.tests')
end
playwrightAdapter.is_test_file = function(file_path)
  return file_path:match('spec.ts')
end

local plenaryAdapter = require('neotest-plenary').setup({
  min_init = '/etc/nixos/vim/spec/test_init.lua',
})

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
    vitestAdapter,
    -- playwrightAdapter,
    plenaryAdapter,
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
  r = { neotest.run.run, 'run.run' },
  a = { neotest.run.attach, 'run.attach' },
  l = { neotest.run.run_last, 'run.run_last' },
  -- s = { neotest.run.stop, 'stop' },
  s = { neotest.summary.toggle, 'summary.toggle' },
  o = { neotest.output_panel.toggle, 'output_panel.toggle' },
  S = { neotest.run.suite, 'run.suite' },
  b = { neotest.run.buffer, 'run.buffer' },
  d = { neotest.run.dap, 'run.dap' },
  c = { [[:!busted<cr>]], '!busted' },
  x = {
    function()
      neotest.summary:expand(vim.loop.cwd(), true)
    end,
    'expand',
  },
}, { prefix = '<leader>n' })
wkr({
  ['<leader>]'] = { require('neotest').summary.toggle, 'summary.toggle' },
  ['<leader>}'] = { require('neotest').output_panel.toggle, 'output_panel.toggle' },
  ['<F9>'] = { neotest.run.buffer, 'run.buffer' },
})
-- mappings = {
--   attach = "a",
--   clear_marked = "M",
--   clear_target = "T",
--   debug = "d",
--   debug_marked = "D",
--   expand = { "<CR>", "<2-LeftMouse>" },
--   expand_all = "e",
--   jumpto = "i",
--   mark = "m",
--   next_failed = "J",
--   output = "o",
--   prev_failed = "K",
--   run = "r",
--   run_marked = "R",
--   short = "O",
--   stop = "u",
--   target = "t"
-- },
