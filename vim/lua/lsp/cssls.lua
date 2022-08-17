-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#cssls
require("lspconfig").cssls.setup({
	capabilities = require("capabilities"),
	on_attach = require("on_attach"),
	flags = require("flags"),
	-- init_options = {
	-- 	-- https://github.com/MaskRay/ccls/wiki/Customization#initialization-options
	-- 	cache = {
	-- 		directory = "~/.cache/ccls-cache",
	-- 	},
	-- 	compilationDatabaseDirectory = "build",
	-- 	index = {
	-- 		threads = 0,
	-- 	},
	-- 	clang = {
	-- 		excludeArgs = { "-frounding-math" },
	-- 	},
	-- },
})
