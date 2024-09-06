vim.cmd [[
" autocmd! BufEnter *.templ setlocal ft=templ
]]

require "lspconfig".gopls.setup {}
vim.api.nvim_create_autocmd({ "BufWritePre", }, {
  group = "Format",
  pattern = { "*.go", },
  callback = function() vim.lsp.buf.format() end,
})

vim.filetype.add { extension = { templ = "templ", }, }
require "lspconfig".templ.setup {}
vim.api.nvim_create_autocmd({ "BufWritePre", }, {
  group = "Format",
  pattern = { "*.templ", },
  callback = function() vim.lsp.buf.format() end,
})

require "dap-go".setup()

-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go-using-delve-directly
-- local dap = require('dap')
-- dap.adapters.delve = {
--   type = 'server',
--   port = '${port}',
--   executable = {
--     command = 'dlv',
--     args = { 'dap', '-l', '127.0.0.1:${port}' },
--   },
-- }
-- dap.configurations.go = {
--   {
--     type = "delve",
--     name = "Debug",
--     request = "launch",
--     program = "${file}",
--   },
--   {
--     type = "delve",
--     name = "Debug test", -- configuration for debugging test files
--     request = "launch",
--     mode = "test",
--     program = "${file}",
--   },
--   -- works with go.mod packages and sub packages
--   {
--     type = "delve",
--     name = "Debug test (go.mod)",
--     request = "launch",
--     mode = "test",
--     program = "./${relativeFileDirname}",
--   },
-- }
