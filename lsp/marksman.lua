-- require('null-ls').register({
--   require('null-ls.builtins.formatting.markdownlint'),
--   require('null-ls.builtins.diagnostics.markdownlint'),
-- })

return {
	cmd = { 'marksman', 'server' },
	filetypes = { 'markdown' },
}
