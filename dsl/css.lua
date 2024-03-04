local ftmap = require('null-ls.builtins._meta.filetype_map').css
local css = {
  diagnostics = { "stylelint" },
  formatting = { "prettier", "prettierd", "stylelint" },
}

-- https://github.com/bmatcuk/stylelint-lsp
local stylelint_lsp = require('lspconfig.server_configurations.stylelint_lsp')

-- https://github.com/hrsh7th/vscode-langservers-extracted
local cssls = require('lspconfig.server_configurations.cssls')
require('lspconfig').cssls.setup({})

vim.api.nvim_create_autocmd({ 'BufWritePre' },
  {
    group = 'Format',
    desc = 'css',
    pattern = { '*.css' },
    callback = function() vim.lsp.buf.format() end,
  })
