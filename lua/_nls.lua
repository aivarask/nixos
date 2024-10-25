local nls = require('null-ls')
nls.setup({
	sources = {
		nls.builtins.formatting.stylua,
	},
	-- diagnostics_format = '#{m} [#{c}] (#{s}) null-ls',
})
