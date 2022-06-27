-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bashls
require("lspconfig").cssls.setup({
	capabilities = require("capabilities"),
	on_attach = require("on_attach"),
	flags = require("flags"),
	cmd = { "bash-language-server", "start" },
	cmd_env = {
		GLOB_PATTERN = "*@(.sh|.inc|.bash|.command)",
	},
	filetypes = { "sh", "zsh" },
	root_dir = require("lspconfig.util").find_git_ancestor,
	single_file_support = true,
})
