vim.fn.sign_define('DapBreakpoint', { text = '🟢', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = '🟡', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '🔴', texthl = '', linehl = '', numhl = '' })

-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
-- dap-configuration nvim-dap
local dap = require 'dap'
dap.defaults.fallback.terminal_win_cmd = '60vsplit new'
-- dap.defaults.fallback.switchbuf = "useopen"
require 'nvim-dap-virtual-text'.setup {}

-- nvim-dap-ui
local dapui = require 'dapui'
dapui.setup {
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
}

