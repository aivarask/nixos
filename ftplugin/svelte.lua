local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

vim.lsp.start({
	name = 'svelteserver',
	cmd = { 'svelteserver', '--stdio' },
	root_dir = vim.fs.root(0, { 'package.json' }),
	-- capabilities = capabilities,
	-- https://github.com/sveltejs/language-tools/tree/master/packages/language-server#settings
})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = { '*.svelte' },
	desc = 'format svelteserver',
	callback = function()
		vim.lsp.buf.format({ name = 'svelteserver' })
	end,
})
