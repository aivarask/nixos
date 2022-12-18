local util = require("lspconfig.util")
require("lspconfig").tsserver.setup({
	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
	-- FIX: deprecated nvim-lsp-ts-utils update to
	-- https://github.com/jose-elias-alvarez/typescript.nvim
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
