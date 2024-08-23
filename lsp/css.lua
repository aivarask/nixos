-- https://github.com/hrsh7th/vscode-langservers-extracted
local cssls = require "lspconfig.server_configurations.cssls"
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
require "lspconfig".cssls.setup {
  capabilities = capabilities,
}

local stylelint_lsp = require "lspconfig.server_configurations.stylelint_lsp"
require "lspconfig".stylelint_lsp.setup {
  -- pnpm i -D stylelint-lsp
  cmd = { "/etc/nixos/node_modules/.bin/stylelint-lsp", "--stdio", },
  filetypes = { "css", },
  settings = {
    -- https://github.com/bmatcuk/stylelint-lsp#settings
    stylelintplus = {
      -- autoFixOnSave = false,
      autoFixOnFormat = true,
      enable = true,
    },
  },
}

vim.api.nvim_create_autocmd({ "BufWritePre", }, { group = "Format", pattern = { "*.css", }, desc = "css", callback = vim.lsp.buf.format,
})
