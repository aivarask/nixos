vim.api.nvim_create_augroup("Format", { clear = true, })
ftmap = require "null-ls.builtins._meta.filetype_map"
nls = require 'null-ls'
lsconfig = require 'lspconfig'

-- php
lsconfig.intelephense.setup { root_dir = require "lspconfig.util".root_pattern("composer.json", ".git", "index.php"), }
vim.api.nvim_create_autocmd({ "BufWritePre", }, { group = "Format", desc = "intelephense", pattern = { "*.php", }, callback = vim.lsp.buf.format, })

-- json
vim.cmd [[ autocmd! BufEnter *.json,flake.lock,.prettierrc setlocal ft=jsonc ]]
local function json()
  return {
    validate = { enable = true, },
    schemas = require "schemastore".json.schemas { --- @see schemastore.txt
      extra = {
        {
          name = "snippets",
          description = "Snippet configuration",
          fileMatch = { "*/snippets/*.json", "!*/snippets/package.json", },
          url = "https://raw.githubusercontent.com/Yash-Singh1/vscode-snippets-json-schema/main/schema.json",
        },
      },
    },
  }
end
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.api.nvim_create_autocmd({ "BufWritePre", }, {
  group = "Format",
  desc = "jsonls",
  pattern = { "*.json", "*.jsonc", },
  callback = function() vim.lsp.buf.format() end,
})
require "lspconfig".jsonls.setup { capabilities = capabilities, settings = { json = json(), }, }
