-- https://github.com/nanotee/nvim-lua-guide
-- https://github.com/folke/lua-dev.nvim
require("neodev").setup({})
require("lspconfig").sumneko_lua.setup({
	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
	capabilities = require("capabilities"),
	on_attach = require("on_attach"),
	flags = require("flags"),
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				maxPreload = 1000,
				preloadFileSize = 10000,
			},
			telemetry = {
				enable = false,
			},
			completion = {
				enable = true,
				callSnippet = "Replace",
				displayContext = 8,
			},
		},
	},
	root_dir = require("lspconfig.util").root_pattern(
		"vimrc.vim",
		".luarc.json",
		".luacheckrc",
		".stylua.toml",
		"stylua.toml",
		"selene.toml",
		".git"
	),
})
