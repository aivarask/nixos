-- https://github.com/nix-community/rnix-lsp
require("lspconfig").rnix.setup({
	capabilities = require("capabilities"),
	on_attach = require("on_attach"),
	flags = require("flags"),

	-- cmd = { "rnix-lsp" },
	-- filetypes = { "nix" },
	-- root_dir = "/etc/nixos",
	-- root_dir = require("lspconfig.util").root_pattern(
	-- 	".git",
	-- 	"shell.nix",
	-- 	"flake.nix",
	-- 	"default.nix",
	-- 	"configuration.nix"
	-- ),
	-- settings = {},
})
