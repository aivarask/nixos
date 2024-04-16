local ftmap = require('null-ls.builtins._meta.filetype_map').rust
local rust = {
  formatting = { "dprint", "leptosfmt", "rustfmt" },
}
require('null-ls').register({
  -- require('null-ls.builtins.formatting.rustfmt'),
})

local rust_analyzer = require('lspconfig.server_configurations.rust_analyzer')
-- require('lspconfig').rust_analyzer.setup({})

vim.api.nvim_create_autocmd({ 'BufWritePre' },
  {
    group = 'Format',
    desc = 'rustfmt',
    pattern = { '*.rs' },
    callback = function() vim.lsp.buf.format() end,
  })

-- https://romangeber.com/blog/tech/nvim_rust_debugger
-- https://github.com/vadimcn/codelldb
-- https://github.com/mrcjkb/rustaceanvim
-- after/ftplugin/rust.lua

-- vim.cmd.RustLsp('debuggables')
-- vim.g.rustaceanvim.dap.autoload_configurations = false

-- local dap = require("dap")

-- dap.adapters.lldb = {
--   type = "executable",
--   command = "codelldb",
--   name = "lldb",
-- }

-- dap.configurations.rust = {
--   {
--     name = "hello-world",
--     type = "lldb",
--     request = "launch",
--     program = function()
--       return vim.fn.getcwd() .. "/target/debug/main"
--     end,
--     cwd = "${workspaceFolder}",
--     stopOnEntry = false,
--   } }
