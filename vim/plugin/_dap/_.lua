-- https://github.com/mfussenegger/nvim-dap
dap = require('dap')
dap.defaults.fallback.terminal_win_cmd = '60vsplit new'
vim.fn.sign_define('DapBreakpoint', { text = '🟢', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = '🟡', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '🔴', texthl = '', linehl = '', numhl = '' })

widgets = require('dap.ui.widgets')

-- https://github.com/rcarriga/nvim-dap-ui
dapui = require('dapui')

function dapui.toggle_reset(args)
  dapui.toggle({ reset = true })
end

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
          size = 0.5,
        },
        {
          id = 'breakpoints',
          size = 0.1,
        },
        {
          id = 'stacks',
          size = 0.20,
        },
        {
          id = 'watches',
          size = 0.20,
        },
      },
      position = 'left',
      size = 50,
    },
    {
      elements = {
        {
          id = 'repl',
          size = 0.5,
        },
        {
          id = 'console',
          size = 0.5,
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
