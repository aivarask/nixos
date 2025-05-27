-- require('null-ls').register({
-- 	require('null-ls.builtins.formatting.sqlfluff').with({ extra_args = { '--dialect', 'sqlite' } }),
-- })
-- local sqlls = require('lspconfig.server_configurations.sqlls')
-- require('lspconfig').sqlls.setup({
--   cmd = { './node_modules/.bin/sql-language-server', 'up', '--method', 'stdio' },
-- })
-- local sqls = require('lspconfig.server_configurations.sqls')
-- require('lspconfig').sqls.setup({ cmd = { "sqls", "-config", "/etc/nixos/sql/.sqls.yml" } })
-- https://github.com/supabase/postgres_lsp
-- local postgres_lsp = require('lspconfig.server_configurations.postgres_lsp')
-- require('lspconfig').postgres_lsp.setup({})
return {
}
