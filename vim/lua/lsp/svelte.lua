local util = require("lspconfig.util")

require("lspconfig").svelte.setup({
	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#svelte
	-- init_options = require("nvim-lsp-ts-utils").init_options, -- not working nor should
	capabilities = require("capabilities"),
	on_attach = require("on_attach"),
	flags = require("flags"),
	-- commands = {},
	cmd = {
		"svelteserver",
		"--stdio",
	},
	filetypes = {
		"svelte",
		-- "typescript",
		-- "markdown.mdx"
	},
	-- root_dir = root_pattern("package.json", ".git"),
	root_dir = util.root_pattern("package.json", ".git"),
	-- settings = {
	-- 	-- https://github.com/sveltejs/language-tools/tree/master/packages/svelte-vscode#settings
	-- enable_ts_plugin = true,
	-- },
})
