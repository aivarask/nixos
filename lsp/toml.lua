local ftmap = require("null-ls.builtins._meta.filetype_map").toml
local toml = {
	formatting = { "dprint", "taplo" },
}

local taplo = require "lspconfig.server_configurations.taplo"
require("lspconfig").taplo.setup {}

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = "Format",
	desc = "taplo",
	pattern = { "*.toml" },
	callback = function() vim.lsp.buf.format {} end,
})
