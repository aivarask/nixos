vim.api.nvim_create_autocmd('FileType', {
	pattern = 'lua',
	callback = function(ev)
		vim.lsp.start({
			name = 'lsp',
			cmd = { 'lsp' },
			root_dir = vim.fs.root(ev.buf, { 'flake.lock' }),
		})
	end,
})
