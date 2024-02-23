local ftmap = require('null-ls.builtins._meta.filetype_map').yaml

local yaml = {
  diagnostics = { "actionlint", "cfn_lint", "spectral", "vacuum", "yamllint" },
  formatting = { "prettier", "prettierd", "yamlfix", "yamlfmt", "yq" },
}

local yamlls = require('lspconfig.server_configurations.yamlls')
-- yaml-language-server
require('lspconfig').yamlls.setup({
  settings = {
    yaml = { format = { enable = true } },
    schemaStore = {
      -- You must disable built-in schemaStore support if you want to use
      -- this plugin and its advanced options like `ignore`.
      enable = false,
      -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
      url = "",
    },
    -- SchemaStore-nvim
    schemas = require('schemastore').yaml.schemas(),
  },
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = 'Format',
  desc = 'yamls',
  pattern = { '*.yaml', '*.yml' },
  callback = function() vim.lsp.buf.format() end,
})
