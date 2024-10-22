local nls = require('null-ls')
nls.setup({
	sources = {
		nls.builtins.formatting.stylua,
		nls.builtins.formatting.nixfmt,
	},
	diagnostics_format = '#{m} [#{c}] (#{s}) null-ls',
})
