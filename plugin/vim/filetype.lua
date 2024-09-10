vim.filetype.add {
	-- extension = { json = "jsonc", },
	filename = {
		['.prettierrc'] = 'json',
	},
}

-- vim.cmd [[
-- autocmd! BufEnter .env* setlocal ft=sh
-- autocmd BufEnter */zsh/* setlocal ft=zsh
-- ]]
