-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#clangd

require("lspconfig").clangd.setup({
	capabilities = require("capabilities"),
	on_attach = require("on_attach"),
	flags = require("flags"),
	-- cmd = { "clangd" },
	-- filetypes = { "c", "cpp", "objc", "objcpp" },
	-- root_dir = require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
	-- single_file_support = true,
})

-- require("lspconfig").cmake.setup({
-- 	capabilities = require("capabilities"),
-- 	on_attach = require("on_attach"),
-- 	flags = require("flags"),
-- 	cmd = { "cmake-language-server" },
-- 	filetypes = { "cmake", "make" },
-- 	init_options = {
-- 		buildDirectory = "build",
-- 	},
-- 	-- root_dir = root_pattern(".git", "compile_commands.json", "build") or dirname
-- 	-- single_file_support = true,
-- })

require("lspconfig").ccls.setup({
	init_options = {
		-- https://github.com/MaskRay/ccls/wiki/Customization#initialization-options
		cache = {
			directory = "~/.cache/ccls-cache",
		},
		compilationDatabaseDirectory = "build",
		index = {
			threads = 0,
		},
		clang = {
			excludeArgs = { "-frounding-math" },
		},
	},
})
