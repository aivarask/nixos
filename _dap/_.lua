vim.fn.sign_define(
  'DapBreakpoint',
  { text = '🟢', texthl = '', linehl = '', numhl = '' }
)
vim.fn.sign_define(
  'DapBreakpointRejected',
  { text = '🟡', texthl = '', linehl = '', numhl = '' }
)
vim.fn.sign_define(
  'DapStopped',
  { text = '🔴', texthl = '', linehl = '', numhl = '' }
)

-- https://github.com/mfussenegger/nvim-dap
dap = require('dap')
dap.defaults.fallback.terminal_win_cmd = '60vsplit new'

require('nvim-dap-virtual-text').setup({})
