-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#prismals
require("lspconfig").prismals.setup({
	capabilities = require("capabilities"),
	on_attach = require("on_attach"),
	flags = require("flags"),
	settings = {
		prisma = {
			-- prismaFmtBinPath = "prisma-fmt",
			-- prismaFmtBinPath = "/nix/store/z1dbamik3x7qs7k6ik0zrq03kfb7iyvq-prisma-engines-3.4.0/bin/prisma-fmt",
		},
	},
})
