neotest = require('neotest')

-- https://github.com/nvim-neotest/neotest
-- https://github.com/nvim-neotest/neotest/blob/master/lua/neotest/config/init.lua#L131
neotest.setup({
  adapters = {
    neotest_plenary,
    bun,
    -- jest,
    playwright,
    vitest,
  },
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
  consumers = {
    playwright = require('neotest-playwright.consumers').consumers,
  },
})

neotest.run.buffer = function()
  neotest.run.run(vim.fn.expand('%'))
end

neotest.run.buffer_dap = function()
  neotest.run.run({ vim.fn.expand('%'), strategy = 'dap' })
end

neotest.run.suite = function()
  neotest.run.run({ suite = true })
end

neotest.run.dap = function()
  neotest.run.run({ strategy = 'dap' })
end

wkr({
  name = 'Neotest',
  ['1'] = { neotest.run.buffer_dap, 'run.buffer_dap' },
  r = { neotest.run.run, 'run.run' },
  a = { neotest.run.attach, 'run.attach' },
  l = { neotest.run.run_last, 'run.run_last' },
  -- s = { neotest.run.stop, 'run.stop' },
  S = { neotest.summary.toggle, 'summary.toggle' },
  o = { neotest.output_panel.toggle, 'output_panel.toggle' },
  s = { neotest.run.suite, 'run.suite' },
  b = { neotest.run.buffer, 'run.buffer' },
  d = { neotest.run.dap, 'run.dap' },
  c = { [[:!busted<cr>]], '!busted' },
  x = {
    function()
      neotest.summary:expand(vim.uv.cwd(), true)
    end,
    'expand',
  },
}, { prefix = '<leader>n' })
