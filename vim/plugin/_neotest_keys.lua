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
      neotest.summary:expand(vim.loop.cwd(), true)
    end,
    'expand',
  },
}, { prefix = '<leader>n' })

