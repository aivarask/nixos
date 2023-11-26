local null_ls = require('null-ls')
null_ls.register({
  null_ls.builtins.diagnostics.yamllint,
  null_ls.builtins.formatting.taplo,
  null_ls.builtins.formatting.fixjson.with({
    filetypes = { 'json', 'jsonc' },
  }),
})

-- https://github.com/SchemaStore/schemastore
-- https://github.com/b0o/SchemaStore.nvim
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jsonls
require('lspconfig').jsonls.setup({
  -- capabilities = capabilities,
  -- on_attach = on_attach,
  init_options = {
    provideFormatter = false,
  },
  settings = {
    format = { enable = false },
    json = {
      -- https://www.schemastore.org/json/
      schemas = vim.list_extend(require('schemastore').json.schemas({}), {
        {
          description = 'Schema for code snippet files in visual studio code extensions',
          fileMatch = { 'snippets/*.json' },
          -- fileMatch = { 'snippets/{*,~package}.json' },
          name = 'Snippets',
          url = 'https://raw.githubusercontent.com/Yash-Singh1/vscode-snippets-json-schema/main/schema.json',
        },
      }),
      validate = { enable = true },
    },
  },
})
