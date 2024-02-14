local neotest = require('neotest')

-- https://github.com/nvim-neotest/neotest
-- neotest.setup
neotest.setup({
  adapters = { require('neotest-plenary'), require('neotest-phpunit') },
  output_panel = {
    open = 'botright vsplit | vertical resize 60 | set winfixwidth',
  },
  summary = {
    open = 'botright vsplit | vertical resize 40 | set winfixwidth',
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

require('which-key').register({
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
  w = {
    name = 'Watch',
    w = { neotest.watch.watch, 'neotest.watch.watch' },
    t = { neotest.watch.toggle, 'neotest.watch.toggle' },
    s = { neotest.watch.stop, 'neotest.watch.stop' },
    ['?'] = {
      function()
        print(neotest.watch.is_watching())
      end,
      'neotest.watch.is_watching',
    },
  },
}, { prefix = '<leader>n' })
