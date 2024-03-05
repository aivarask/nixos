local ftmap = require('null-ls.builtins._meta.filetype_map').css
local css = {
  diagnostics = { "stylelint" },
  formatting = { "prettier", "prettierd", "stylelint" },
}

-- https://github.com/hrsh7th/vscode-langservers-extracted
local cssls = require('lspconfig.server_configurations.cssls')
require('lspconfig').cssls.setup({})

-- ../.stylelintrc.json
-- https://stylelint.io/user-guide/rules
-- https://github.com/bmatcuk/stylelint-lsp
-- https://github.com/stylelint/stylelint-config-standard/blob/main/index.js
-- https://github.com/stylelint/stylelint-config-recommended/blob/main/index.js
local stylelint_lsp = require('lspconfig.server_configurations.stylelint_lsp')
require('lspconfig').stylelint_lsp.setup({
  -- pnpm i -D stylelint-lsp
  cmd = { '/etc/nixos/node_modules/.bin/stylelint-lsp', '--stdio' },
  filetypes = { 'css' },
  settings = {
    -- https://github.com/bmatcuk/stylelint-lsp#settings
    stylelintplus = {
      -- autoFixOnSave = false,
      autoFixOnFormat = true,
      enable = true,
    },
  },
})

vim.api.nvim_create_autocmd({ 'BufWritePre' },
  {
    group = 'Format',
    desc = 'css',
    pattern = { '*.css' },
    callback = function() vim.lsp.buf.format() end,
  })
