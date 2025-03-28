-- require('null-ls').register({ require('null-ls.builtins.formatting.black') })
return {
	cmd = {
		'pyright-langserver',
		'--stdio',
	},
	filetypes = { 'python' },
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = 'openFilesOnly',
				stubPath = '/run/current-system/sw/lib/python3.12/site-packages',
			},
		},
	},
}
