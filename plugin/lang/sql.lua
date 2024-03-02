local ftmap = require('null-ls.builtins._meta.filetype_map').sql

local sql = {
  diagnostics = { "sqlfluff" },
  formatting = { "pg_format", "sql_formatter", "sqlfluff", "sqlfmt", "sqlformat" },
}
-- require('null-ls').register({
--   require('null-ls.builtins.diagnostics.sqlfluff').with({
--     extra_args = { "--dialect", "sqlite" },
--   }),
--   require('null-ls.builtins.formatting.sqlfluff').with({
--     extra_args = { "--dialect", "sqlite" },
--   }),
-- })

local sqls = require('lspconfig.server_configurations.sqls')
require('lspconfig').sqls.setup({
  cmd = { "sqls", "-config", "/etc/nixos/sqls.yml" },
})

-- local postgres_lsp = require('lspconfig.server_configurations.postgres_lsp')
-- require('lspconfig').postgres_lsp.setup({})

vim.api.nvim_create_autocmd({ 'BufWritePre' },
  {
    group = 'Format',
    desc = 'sqls',
    pattern = { '*.sql' },
    callback = function() vim.lsp.buf.format() end,
  })
