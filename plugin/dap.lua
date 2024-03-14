vim.fn.sign_define('DapBreakpoint', { text = '🟢', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = '🟡', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '🔴', texthl = '', linehl = '', numhl = '' })

-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
-- dap-configuration nvim-dap
local dap = require('dap')
dap.defaults.fallback.terminal_win_cmd = '60vsplit new'
require('nvim-dap-virtual-text').setup({})

-- nvim-dap-ui
local dapui = require('dapui')
dapui.setup({})
function dapui.toggle_reset(args) dapui.toggle({ reset = true }) end

widgets = require('dap.ui.widgets')


require('which-key').register({
  name = 'DAP',
  c = { dap.continue, 'continue' },
  r = { dap.run, 'run' },
  l = { dap.run_last, 'run_last' },
  R = { dap.restart, 'restart' },
  T = { dap.terminate, 'terminate' },
  --
  b = {
    name = 'breakpoint',
    s = { dap.set_breakpoint, 'set_breakpoint' },
    t = { dap.toggle_breakpoint, 'toggle_breakpoint' },
    l = { dap.list_breakpoints, 'list_breakpoints' },
    c = { dap.clear_breakpoints, 'clear_breakpoints' },
    x = { dap.set_exception_breakpoints, 'set_exception_breakpoints' },
  },
  s = {
    name = 'step',
    j = { dap.step_over, 'over' },
    l = { dap.step_into, 'into' },
    h = { dap.step_out, 'out' },
    k = { dap.step_back, 'back' },
  },
  P = { dap.pause, 'pause' },
  -- dap.reverse_continue
  -- dap.up
  -- dap.down
  -- dap.goto
  f = {
    name = 'frame',
    f = { dap.focus_frame, 'focus_frame' },
    r = { dap.restart_frame, 'restart_frame' },
  },
  x = { dap.run_to_cursor, 'run_to_cursor' },
  ['<F12>'] = { dap.repl.toggle, 'repl.toggle' },
  --
  S = { dap.status, 'status' },
  D = { dap.disconnect, 'disconnect' },
  C = { dap.close, 'close' },
  L = { dap.launch, 'launch' },
  A = { dap.attach, 'attach' },
  -- dap-widgets
  h = { widgets.hover, 'widgets.hover' },
  p = { widgets.preview, 'widgets.preview' },
  -- S = { [[:lua widgets.centered_float(widgets.scopes)<cr>]], 'widgets.scopes' },
  t = { dapui.toggle_reset, 'dapui.toggle' },
}, { prefix = '<leader>d' })
