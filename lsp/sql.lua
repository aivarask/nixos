local ftmap = require('null-ls.builtins._meta.filetype_map').sql

local sql = {
  diagnostics = { "sqlfluff" },
  formatting = { "pg_format", "sql_formatter", "sqlfluff", "sqlfmt", "sqlformat" },
}
require('null-ls').register({
  require('null-ls.builtins.diagnostics.sqlfluff').with({
    extra_args = { "--dialect", "sqlite" },
  }),
  require('null-ls.builtins.formatting.sqlfluff').with({
    extra_args = { "--dialect", "sqlite" },
  }),
})

-- local sqlls = require('lspconfig.server_configurations.sqlls')
-- require('lspconfig').sqlls.setup({
--   cmd = { './node_modules/.bin/sql-language-server', 'up', '--method', 'stdio' },
-- })

-- local sqls = require('lspconfig.server_configurations.sqls')
-- require('lspconfig').sqls.setup({ cmd = { "sqls", "-config", "/etc/nixos/sql/.sqls.yml" } })

-- https://github.com/supabase/postgres_lsp
-- local postgres_lsp = require('lspconfig.server_configurations.postgres_lsp')
-- require('lspconfig').postgres_lsp.setup({})

vim.api.nvim_create_autocmd({ 'BufWritePre' },
  {
    group = 'Format',
    desc = 'null-ls sqlfluff',
    pattern = { '*.sql' },
    -- callback = vim.lsp.buf.format,
    callback = function(client)
      vim.lsp.buf.format()
    end,
  })
