-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#vimls
local root_pattern = require("lspconfig.util").root_pattern
require("lspconfig").vimls.setup({
	capabilities = require("capabilities"),
	on_attach = require("on_attach"),
	flags = require("flags"),
	cmd = { "vim-language-server", "--stdio" },
	filetypes = { "vim" },
	init_options = {
		diagnostic = {
			enable = true,
		},
		indexes = {
			count = 3,
			gap = 100,
			projectRootPatterns = { "runtime", "nvim", ".git", "autoload", "plugin" },
			runtimepath = true,
		},
		isNeovim = true,
		iskeyword = "@,48-57,_,192-255,-#",
		runtimepath = "",
		suggest = {
			fromRuntimepath = true,
			fromVimruntime = true,
		},
		vimruntime = "",
	},
	root_dir = root_pattern("vimrc.vim"),
	single_file_support = true,
})
