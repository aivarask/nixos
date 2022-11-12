require("lspconfig").sqlls.setup({
  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sqlls
	capabilities = require("capabilities"),
	on_attach = require("on_attach"),
	flags = require("flags"),
})
