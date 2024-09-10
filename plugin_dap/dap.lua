vim.fn.sign_define("DapBreakpoint", { text = "🟢", texthl = "", linehl = "", numhl = "", })
vim.fn.sign_define("DapBreakpointRejected", { text = "🟡", texthl = "", linehl = "", numhl = "", })
vim.fn.sign_define("DapStopped", { text = "🔴", texthl = "", linehl = "", numhl = "", })

-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
-- dap-configuration nvim-dap
local dap = require "dap"
dap.defaults.fallback.terminal_win_cmd = "60vsplit new"
-- dap.defaults.fallback.switchbuf = "useopen"
require "nvim-dap-virtual-text".setup {}


-- dap-vscode-js
require "dap-vscode-js".setup {
  debugger_cmd = { "js-debug", },
  adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost", },
}
require "dap".configurations.javascript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "pwa-node launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
}
