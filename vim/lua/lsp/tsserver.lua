local util = require("lspconfig.util")
require("lspconfig").tsserver.setup({
	init_options = require("nvim-lsp-ts-utils").init_options,
	capabilities = require("capabilities"),
	on_attach = require("on_attach"),
	flags = require("flags"),
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		-- "svelte",
	},
	root_dir = util.root_pattern("package.json", ".git"),
})
