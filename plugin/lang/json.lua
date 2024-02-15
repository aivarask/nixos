local null_ls = require('null-ls')
null_ls.register({
  null_ls.builtins.formatting.fixjson.with({
    filetypes = { 'json', 'jsonc' },
  }),
})

local function json()
  return {
    validate = { enable = true },
    schemas = require('schemastore').json.schemas({
      extra = {
        {
          description = 'Snippet configuration',
          fileMatch = { '*/snippets/*.json', '!*/snippets/package.json' },
          name = 'snippets',
          url = 'https://raw.githubusercontent.com/Yash-Singh1/vscode-snippets-json-schema/main/schema.json',
        },
        --   {
        --     description = 'sqlls config',
        --     fileMatch = '*/.sqllsrc.json',
        --     name = 'sqllsrc',
        --     url = '/etc/nixos/schemas/sqllsrc.json',
        --   },
        --   {
        --     description = 'sqlint config',
        --     fileMatch = '*/.sqlintrc.json',
        --     name = 'sqlintrc',
        --     url = '/etc/nixos/schemas/sqlint.json',
        --   },
      },
    }),
  }
end

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jsonls
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
require('lspconfig').jsonls.setup({
  capabilities = capabilities,
  settings = { json = json() },
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*.json', '*.jsonc' },
  callback = function() vim.lsp.buf.format() end,
})
