-- https://github.com/jose-elias-alvarez/typescript.nvim
require("typescript").setup({
	disable_commands = false, -- prevent the plugin from creating Vim commands
	debug = false, -- enable debug logging for commands
	go_to_source_definition = {
		fallback = true, -- fall back to standard LSP definition on failure
	},
	server = { -- pass options to lspconfig's setup method
		on_attach = require("on_attach"),
		init_options = require("nvim-lsp-ts-utils").init_options,
		capabilities = require("capabilities"),
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
		-- root_dir = util.root_pattern("package.json", ".git"),
	},
})
