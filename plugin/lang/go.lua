local ftmap = require('null-ls.builtins._meta.filetype_map').go
local go = {
  code_actions = { "gomodifytags", "impl", "refactoring" },
  diagnostics = { "golangci_lint", "gospel", "revive", "semgrep", "staticcheck" },
  formatting = { "gofmt", "gofumpt", "goimports", "goimports_reviser", "golines" },
}
local gopls = require('lspconfig.server_configurations.gopls')
require('lspconfig').gopls.setup({})
vim.api.nvim_create_autocmd({ 'BufWritePre' },
  { group = 'Format', desc = 'gopls', pattern = { '*.go' }, callback = vim.lsp.buf.format })


local templ = require('lspconfig.server_configurations.templ')
vim.filetype.add({ extension = { templ = 'templ' } })
require('lspconfig').templ.setup({})
vim.api.nvim_create_autocmd({ 'BufWritePre' },
  { group = 'Format', desc = 'templ', pattern = { '*.templ' }, callback = vim.lsp.buf.format })
