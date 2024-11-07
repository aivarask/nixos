local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

vim.lsp.start({
	cmd = { 'svelteserver', '--stdio' },
	root_dir = vim.fs.root(0, { 'package.json' }),
	-- capabilities = capabilities,
	-- https://github.com/sveltejs/language-tools/tree/master/packages/language-server#settings
	-- init_options = {},
})

require('lspconfig.configs.svelte')
-- require('lspconfig').svelte.setup({
-- 	capabilities = capabilities,
-- })
-- vim.api.nvim_create_autocmd('FileType', {
-- 	pattern = { 'svelte' },
-- 	callback = function(ev)
-- 		vim.lsp.start({
-- 			cmd = { 'svelteserver', '--stdio' },
-- 			-- root_dir = vim.fs.root(ev.buf, { 'package.json' }),
-- 			root_dir = vim.fs.root(0, { 'package.json' }),
-- 			capabilities = capabilities,
-- 			-- https://github.com/sveltejs/language-tools/tree/master/packages/language-server#settings
-- 			-- init_options = {},
-- 		})
-- 	end,
-- })

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = { '*.svelte' },
	desc = 'format svelteserver',
	callback = function()
		vim.lsp.buf.format({ name = 'svelteserver' })
	end,
})
