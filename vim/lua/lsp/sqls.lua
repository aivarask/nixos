require("lspconfig").sqls.setup({
	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sqls
	-- https://github.com/lighttiger2505/sqls
	capabilities = require("capabilities"),
	on_attach = require("on_attach"),
	flags = require("flags"),
})
