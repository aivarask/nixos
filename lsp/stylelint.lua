return {
	filetypes = { 'css', 'scss', 'less' },
	cmd = { 'stylelint-lsp', '--stdio' },
	settings = {
		stylelintplus = {
			enable = true,
			autoFixOnFormat = true,
			autoFixOnSave = true,
		},
	},
}
