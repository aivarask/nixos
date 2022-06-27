-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#vimls
require("lspconfig").vimls.setup({
	capabilities = require("capabilities"),
	on_attach = require("on_attach"),
	flags = require("flags"),
})
