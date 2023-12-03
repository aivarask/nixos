wkr({
  ['<F1>'] = { help_cword, 'help_cword' },
  ['<F13>'] = { help_cWORD, 'help_cWORD' },
  ['<F25>'] = { help_cexpr, 'help_cexpr' },
  -- ['<F2>'] = ../_lsp/~.lua
  -- ['<F3>'] = ../_lsp/~.lua
  ['<F4>'] = { dap.restart_frame, 'dap.restart_frame' },
  ['<F5>'] = {
    function()
      if vim.bo.ft == 'lua' then
        osv.run_this()
      else
        dap.continue()
      end
    end,
    'dap.continue',
  },
  ['<F6>'] = { dapui.toggle_reset, 'dapui.toggle_reset' },
  ['<F7>'] = { neotest.run.dap, 'neotest.run.dap' },
  ['<F8>'] = { dap.toggle_breakpoint, 'dap.toggle_breakpoint' },
  ['<F9>'] = { neotest.run.buffer, 'run.buffer' },
  -- ['<F10>'] = { [[:match Search /<C-R><C-W>/<CR>]], ':match Search' },
  ['<F10>'] = {
    function()
      pp('Yeah, maybe it will work')
      require('naughty').notify({
        title = 'Fooo',
        message = "You're idling",
        timeout = 0,
      })
    end,
    'some cool stuff',
  },
  -- NOTE: F11 fullscreen functionality
  ['<F23>'] = {
    "<cmd>exec 'ToggleTerm direction=vertical dir=' .. expand('%:p:h')<CR>",
    'ToggleTerm relative vertical',
    mode = { 'n', 'i', 't' },
  },
  ['<F35>'] = {
    "<cmd>exec 'ToggleTerm direction=tab dir=' .. expand('%:p:h')<CR>",
    'ToggleTerm relative tab',
    mode = { 'n', 'i', 't' },
  },
  ['<F12>'] = {
    '<cmd>ToggleTerm direction=horizontal<CR>',
    'ToggleTerm',
    mode = { 'n', 'i', 't' },
  },
  ['<F24>'] = {
    '<cmd>ToggleTerm direction=vertical<CR>',
    'ToggleTerm',
    mode = { 'n', 'i', 't' },
  },
  ['<F36>'] = {
    '<cmd>ToggleTerm direction=tab<CR>',
    'ToggleTerm',
    mode = { 'n', 'i', 't' },
  },
})
