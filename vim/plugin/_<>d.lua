-- https://github.com/mfussenegger/nvim-dap
local dap = require('dap')
dap.defaults.fallback.terminal_win_cmd = '60vsplit new'
vim.fn.sign_define('DapBreakpoint', { text = '🟢', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = '🟡', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '🔴', texthl = '', linehl = '', numhl = '' })

-- https://github.com/rcarriga/nvim-dap-ui
local dapui = require('dapui')
require('dapui').setup({
  controls = {
    element = 'repl',
    enabled = true,
    icons = {
      disconnect = '',
      pause = '',
      play = '',
      run_last = '',
      step_back = '',
      step_into = '',
      step_out = '',
      step_over = '',
      terminate = '',
    },
  },
  element_mappings = {},
  expand_lines = true,
  floating = {
    border = 'single',
    mappings = {
      close = { 'q', '<Esc>' },
    },
  },
  force_buffers = true,
  icons = {
    collapsed = '',
    current_frame = '',
    expanded = '',
  },
  layouts = {
    {
      elements = {
        {
          id = 'scopes',
          size = 0.25,
        },
        {
          id = 'breakpoints',
          size = 0.25,
        },
        {
          id = 'stacks',
          size = 0.25,
        },
        {
          id = 'watches',
          size = 0.25,
        },
      },
      position = 'left',
      size = 50,
    },
    {
      elements = {
        -- {
        --   id = 'repl',
        --   size = 0.5,
        -- },
        {
          id = 'console',
          size = 1,
        },
      },
      position = 'bottom',
      size = 20,
    },
  },
  mappings = {
    edit = 'e',
    expand = { '<CR>', '<2-LeftMouse>' },
    open = 'o',
    remove = 'd',
    repl = 'r',
    toggle = 't',
  },
  render = {
    indent = 1,
    max_value_lines = 100,
  },
})
dapui.toggle_reset = function()
  dapui.toggle({ reset = true })
end

-- dap-mappings
wkr({
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
  -- L = {
  --   function()
  --     require('dap.ext.vscode').load_launchjs('launch.json')
  --   end,
  --   'launch.json',
  -- },
  A = { dap.attach, 'attach' },
  -- dap-widgets
  h = { widgets.hover, 'widgets.hover' },
  p = { widgets.preview, 'widgets.preview' },
  -- S = { [[:lua widgets.centered_float(widgets.scopes)<cr>]], 'widgets.scopes' },
  t = {
    function()
      dapui.toggle({ reset = true })
    end,
    'dapui.toggle',
  },
}, { prefix = '<leader>d' })

wkr({
  ['<F4>'] = { dap.restart_frame, 'restart_frame' },
  ['<F5>'] = { dap.continue, 'continue' },
  ['<F6>'] = { dapui.toggle_reset, 'dapui.toggle_reset' },
  ['<F8>'] = { dap.toggle_breakpoint, 'toggle_breakpoint' },
  ['<leader><leader>d'] = {
    function()
      dapui.toggle({ reset = true })
    end,
    'dapui.toggle',
  },
})
