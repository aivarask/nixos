require("lspconfig").emmet_ls.setup({
	capabilities = require("capabilities"),
	on_attach = require("on_attach"),
	flags = require("flags"),
	root_dir = function(fname)
		return vim.loop.cwd()
	end,

	filetypes = { "html", "css", "pug", "jade" },
})
