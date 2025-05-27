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
				autosearchpaths = true,
				uselibrarycodefortypes = true,
				diagnosticmode = 'openfilesonly',
				stubpath = '/run/current-system/sw/lib/python3.12/site-packages',
			},
		},
	},
}
