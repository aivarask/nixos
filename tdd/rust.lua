-- https://romangeber.com/blog/tech/nvim_rust_debugger
-- https://github.com/vadimcn/codelldb
-- https://github.com/mrcjkb/rustaceanvim
-- after/ftplugin/rust.lua

-- vim.cmd.RustLsp('debuggables')
-- vim.g.rustaceanvim.dap.autoload_configurations = false

local dap = require("dap")

dap.adapters.lldb = {
  type = "executable",
  command = "codelldb",
  name = "lldb",
}

dap.configurations.rust = {
  {
    name = "launch main",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.getcwd() .. "/target/debug/main"
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}
