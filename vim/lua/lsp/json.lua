require("lspconfig").jsonls.setup({
  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jsonls
  capabilities = require("capabilities"),
  on_attach = require("on_attach"),
  flags = require("flags"),
  init_options = {
    provideFormatter = false,
  },
  settings = {
    format = { enable = true },
    json = {
      schemas = vim.list_extend(
        require("schemastore").json.schemas({
          -- select = {
          --   -- https://github.com/SchemaStore/schemastore/blob/master/src/api/json/catalog.json
          --   ".eslintrc",
          --   "package.json",
          --   -- "vercel.json",
          --   "Vercel",
          --   "VSCode Code Snippets"
          -- },
        }),
        {
        {
          description = "Schema for code snippet files in visual studio code extensions",
          fileMatch = { "snippets/*.json" },
          name = "Snippets",
          url = "https://raw.githubusercontent.com/Yash-Singh1/vscode-snippets-json-schema/main/schema.json",
        },
      }
      ),
    },
  },
})
