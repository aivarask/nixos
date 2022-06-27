-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#stylelint_lsp
require("lspconfig").stylelint_setup({
	capabilities = require("capabilities"),
	on_attach = require("on_attach"),
	flags = require("flags"),
})
