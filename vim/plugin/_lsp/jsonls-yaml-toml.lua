local null_ls = require('null-ls')
null_ls.register({
  null_ls.builtins.diagnostics.yamllint,
  null_ls.builtins.formatting.taplo,
  null_ls.builtins.formatting.fixjson.with({
    filetypes = { 'json', 'jsonc' },
  }),
  -- https://github.com/jqlang/jq
  -- null_ls.builtins.formatting.jq.with({
  --   filetypes = { 'json', 'jsonc' },
  -- }),
})

--- [plugin](https://github.com/b0o/SchemaStore.nvim)
--- [repo](https://github.com/SchemaStore/schemastore)
--- [web](https://www.schemastore.org/json/)
--- [docs](https://json-schema.org/learn/getting-started-step-by-step)
--- [catalog](https://github.com/SchemaStore/schemastore/blob/master/src/api/json/catalog.json)
local function json()
  return {
    schemas = require('schemastore').json.schemas({
      extra = {
        {
          description = 'sqlls config',
          fileMatch = '*/.sqllsrc.json',
          name = 'sqllsrc',
          url = '/etc/nixos/vim/schemas/sqllsrc.json',
        },
        {
          description = 'sqlint config',
          fileMatch = '*/.sqlintrc.json',
          name = 'sqlintrc',
          url = '/etc/nixos/vim/schemas/sqlint.json',
        },
        {
          description = 'Snippet configuration',
          fileMatch = { '*/snippets/*.json', '!*/snippets/package.json' },
          name = 'snippets',
          url = 'https://raw.githubusercontent.com/Yash-Singh1/vscode-snippets-json-schema/main/schema.json',
        },
      },
    }),
    validate = { enable = true },
  }
end

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jsonls
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
require('lspconfig').jsonls.setup({
  capabilities = capabilities,
  settings = {
    json = json(),
  },
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#yamlls
require('lspconfig').yamlls.setup({
  settings = {
    yaml = {
      schemaStore = {
        -- You must disable built-in schemaStore support if you want to use
        -- this plugin and its advanced options like `ignore`.
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = '',
      },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#taplo
require('lspconfig').taplo.setup({})
