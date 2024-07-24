vim.fn.sign_define('DapBreakpoint', { text = '🟢', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = '🟡', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '🔴', texthl = '', linehl = '', numhl = '' })

-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
-- dap-configuration nvim-dap
local dap = require('dap')
dap.defaults.fallback.terminal_win_cmd = '60vsplit new'
-- dap.defaults.fallback.switchbuf = "useopen"
require('nvim-dap-virtual-text').setup({})

-- nvim-dap-ui
local dapui = require('dapui')
dapui.setup({
  layouts = {
    {
      elements = {
        {
          id = "scopes",
          size = 0.70,
        },
        { id = "breakpoints", size = 0.15 },
        {
          id = "stacks",
          size = 0.15,
        },
        -- { id = "watches",     size = 0.25 },
      },
      size = 40,
      position = "right",
    },
    {
      elements = {
        "repl",
        -- "console",
      },
      size = 20,
      position = "bottom",
    },
  },
})

widgets = require('dap.ui.widgets')
require('persistent-breakpoints').setup {
  load_breakpoints_event = { "BufReadPost" },
}

wk.add({
  { '<leader>d', group = 'DAP', icon = '🐞' },
  { '<leader>dc', dap.continue, desc = 'continue' },
  { '<leader>dr', dap.run, desc = 'run' },
  { '<leader>dl', dap.run_last, desc = 'run_last' },
  { '<leader>dR', dap.restart, desc = 'restart' },
  { '<leader>dt', function() dapui.toggle({ reset = true }) end, desc = 'dapui.toggle' },
  { '<leader>dT', dap.terminate, desc = 'terminate' },
  { '<leader>dB', dap.step_back, desc = 'step_back' },
  { '<leader>db', group = 'breakpoint', icon = '🔴' },
  { '<leader>dbs', dap.set_breakpoint, desc = 'set_breakpoint' },
  { '<leader>dbt', dap.toggle_breakpoint, desc = 'toggle_breakpoint' },
  { '<leader>dbl', dap.list_breakpoints, desc = 'list_breakpoints' },
  { '<leader>dbc', dap.clear_breakpoints, desc = 'clear_breakpoints' },
  { '<leader>dbx', dap.set_exception_breakpoints, desc = 'set_exception_breakpoints' },
  { '<leader>ds', group = 'step', icon = '🔀' },
  { '<leader>dsj', dap.step_over, desc = 'over' },
  { '<leader>dsl', dap.ste_into, desc = 'into' },
  { '<leader>dsh', dap.step_out, desc = 'out' },
  { '<leader>dsk', dap.step_back, desc = 'back' },
  --P = { dap.pause, 'pause' },
  ---- dap.reverse_continue
  ---- dap.up
  ---- dap.down
  ---- dap.goto
  --f = {
  --  name = 'frame',
  --  f = { dap.focus_frame, 'focus_frame' },
  --  r = { dap.restart_frame, 'restart_frame' },
  --},
  --x = { dap.run_to_cursor, 'run_to_cursor' },
  --['<F12>'] = { dap.repl.toggle, 'repl.toggle' },
  ----
  --S = { dap.status, 'status' },
  --D = { dap.disconnect, 'disconnect' },
  --C = { dap.close, 'close' },
  --L = { dap.launch, 'launch' },
  --A = { dap.attach, 'attach' },
  ---- dap-widgets
  --h = { widgets.hover, 'widgets.hover' },
  --p = { widgets.preview, 'widgets.preview' },
  ---- S = { [[:lua widgets.centered_float(widgets.scopes)<cr>]], 'widgets.scopes' },
})
