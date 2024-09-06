vim.api.nvim_create_augroup("Format", { clear = true, })
ftmap = require "null-ls.builtins._meta.filetype_map"
nls = require "null-ls"
local nls = require "null-ls"
require "null-ls".setup {
  sources = {
    nls.builtins.code_actions.refactoring,
  },
  diagnostics_format = "#{m} [#{c}] (#{s}) null-ls",
}
lsconfig = require "lspconfig"

-- json
vim.cmd [[ autocmd! BufEnter *.json,flake.lock,.prettierrc setlocal ft=jsonc ]]
vim.api.nvim_create_autocmd({ "BufWritePre", }, {
  group = "Format",
  desc = "jsonls",
  pattern = { "*.json", "*.jsonc", },
  callback = function() vim.lsp.buf.format() end,
})
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.set_log_level 'off'
require "lspconfig".jsonls.setup {
  capabilities = capabilities,
  settings = { json = {
    schemas = require "schemastore".json.schemas {
      extra = {
        {
          fileMatch = { "*/snippets/*.json", "!*/snippets/package.json", },
          name = "snippets",
          url = "https://raw.githubusercontent.com/Yash-Singh1/vscode-snippets-json-schema/main/schema.json",
        },
      },
    },
    validate = { enable = true, },
  },
  },
}
