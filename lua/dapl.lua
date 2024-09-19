vim.fn.sign_define('DapBreakpoint', { text = '🟢', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = '🟡', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '🔴', texthl = '', linehl = '', numhl = '' })

dap = require('dap') --- @see dap.txt
dapui = require('dap.ui')
dapw = require('dap.ui.widgets')
dap.set_log_level('info')
dap.defaults.fallback.terminal_win_cmd = '60vsplit new'
dap.defaults.fallback.switchbuf = 'useopen'
pb = require('persistent-breakpoints.api')
require('persistent-breakpoints').setup({ load_breakpoints_event = { 'BufReadPost' } })
require('nvim-dap-virtual-text').setup({})
require('telescope').load_extension('dap')

local wk = require('which-key')
wk.add({
  { '<leader>d', group = 'DAP' },
  { '<leader>da', dap.attach, desc = 'attach' },
  { '<leader>dB', dap.step_back, desc = 'step_back' },
  { '<leader>db', group = 'breakpoint' },
  -- { '<leader>dbc', dap.clear_breakpoints, desc = 'clear_breakpoints' },
  {
    '<leader>dbc',
    function()
      return pb.clear_all_breakpoints()
    end,
    desc = 'clear_breakpoints',
  },
  { '<leader>dbl', dap.list_breakpoints, desc = 'list_breakpoints' },
  { '<leader>dbs', dap.set_breakpoint, desc = 'set_breakpoint' },
  -- { '<leader>dbt', dap.toggle_breakpoint, desc = 'toggle_breakpoint' },
  { '<leader>dbt', pb.toggle_breakpoint, desc = 'toggle_breakpoint' },
  { '<leader>dbx', dap.set_exception_breakpoints, desc = 'set_exception_breakpoints' },
  { '<leader>dc', dap.continue, desc = 'continue' },
  { '<leader>dC', dap.reverse_continue, desc = 'reverse_continue' },
  { '<leader>dd', dap.disconnect, desc = 'disconnect' },
  { '<leader>df', group = 'frame' },
  { '<leader>dff', dap.focus_frame, desc = 'focus_frame' },
  { '<leader>dfr', dap.restart_frame, desc = 'restart_frame' },
  { '<leader>dL', dap.launch, desc = 'launch' },
  { '<leader>dl', dap.run_last, desc = 'run_last' },
  { '<leader>dp', dap.pause, desc = 'pause' },
  { '<leader>dR', dap.restart, desc = 'restart' },
  { '<leader>dr', dap.run, desc = 'run' },
  { '<leader>dS', dap.status, desc = 'status' },
  { '<leader>ds', group = 'step' },
  { '<leader>dsh', dap.step_out, desc = 'out' },
  { '<leader>dsj', dap.step_over, desc = 'over' },
  { '<leader>dsk', dap.step_back, desc = 'back' },
  { '<leader>dsl', dap.step_into, desc = 'into' },
  { '<leader>dT', dap.repl.toggle, desc = 'repl.toggle' },
  { '<leader>dU', dap.down, desc = 'down' },
  { '<leader>du', dap.up, desc = 'up' },
  { '<leader>dx', dap.run_to_cursor, desc = 'run_to_cursor' },
  { '<leader>dz', dap.close, desc = 'close' },
  { '<leader>dZ', dap.terminate, desc = 'terminate' },
  { '<leader>dw', dapw.hover, desc = 'widgets.hover' },
  { '<leader>dp', dapw.preview, desc = 'widgets.preview' },
  {
    '<leader>dX',
    function()
      dapw.centered_float(dapw.scopes)
    end,
    desc = 'widgets.scopes',
  },
})

dap.adapters = {
	--- @see one
  osv = function(callback, config, parent)
    -- print(vim.inspect(config))
  end,
}

--- @see dap-configuration
-- dap.configurations.osv
