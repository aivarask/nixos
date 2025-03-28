return {
	cmd = { 'intelephense', '--stdio' },
	filetypes = { 'php' },
	settings = {
		intelephense = {
			files = {
				maxSize = 1000000,
			},
		},
	},
}
