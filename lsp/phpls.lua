return {
	cmd = { 'intelephense', '--stdio' },
	filetypes = {
		'php',
		'phtml',
		-- 'html'
	},
	settings = {
		intelephense = {
			files = {
				maxSize = 1000000,
			},
		},
	},
}
