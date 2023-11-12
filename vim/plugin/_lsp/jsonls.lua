-- https://github.com/SchemaStore/schemastore
-- https://github.com/b0o/SchemaStore.nvim
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jsonls
require('lspconfig').jsonls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  init_options = {
    provideFormatter = false,
  },
  settings = {
    format = { enable = true },
    json = {
      -- https://www.schemastore.org/json/
      schemas = vim.list_extend(require('schemastore').json.schemas({}), {
        {
          description = 'Schema for code snippet files in visual studio code extensions',
          -- fileMatch = { 'snippets/*.json' },
          fileMatch = { 'snippets/{*,~package}.json' },
          name = 'Snippets',
          url = 'https://raw.githubusercontent.com/Yash-Singh1/vscode-snippets-json-schema/main/schema.json',
        },
      }),
      validate = { enable = true },
    },
  },
})
