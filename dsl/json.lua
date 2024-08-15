vim.cmd [[
autocmd! BufEnter *.json,flake.lock,.prettierrc setlocal ft=jsonc
]]

local ftmap = require 'null-ls.builtins._meta.filetype_map'.json
local jsonc = {
  diagnostics = { "cfn_lint", "jsonlint", "spectral", "vacuum" },
  formatting = { "biome", "deno_fmt", "dprint", "fixjson", "jq", "json_tool", "prettier", "prettierd" },
}
-- none-ls-nvim

-- require('null-ls').register({ require('null-ls.builtins.formatting.fixjson').with({ filetypes = { 'json', 'jsonc' } }) })

local function json()
  return {
    validate = { enable = true },
    -- SchemaStore-nvim
    schemas = require 'schemastore'.json.schemas {
      extra = {
        {
          description = 'Snippet configuration',
          fileMatch = { '*/snippets/*.json', '!*/snippets/package.json' },
          name = 'snippets',
          url = 'https://raw.githubusercontent.com/Yash-Singh1/vscode-snippets-json-schema/main/schema.json',
        },
      },
    },
  }
end

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jsonls

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
-- vscode-langservers-extracted

require 'lspconfig'.jsonls.setup {
  autostart = false,
  capabilities = capabilities,
  settings = { json = json() },
}

vim.api.nvim_create_autocmd({ 'BufWritePre' },
  {
    group = 'Format',
    desc = 'jsonls',
    pattern = { '*.json', '*.jsonc' },
    callback = function() vim.lsp.buf.format() end,
  })
