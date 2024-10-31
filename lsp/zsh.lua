vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'sh', 'bash', 'zsh' },
	callback = function()
		vim.lsp.start({
			name = 'bash-language-server',
			cmd = { 'bash-language-server', 'start' },
			settings = {
				bashIde = {
					globPattern = '*@(.sh|.inc|.bash|.command|.zsh)',
					-- shellcheckArguments = { '--shell=bash' },
				},
			},
		})
	end,
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = { '*.sh', '*.bash', '*.zsh' },
	desc = 'vim.lsp.buf.format bash-language-server 1000',
	callback = function()
		vim.lsp.buf.format({ name = 'bash-language-server' })
	end,
})
