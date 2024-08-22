local ftmap = require("null-ls.builtins._meta.filetype_map").zig
local zig = {
	formatting = { "zigfmt" },
}

local zls = require "lspconfig.server_configurations.zls"
require("lspconfig").zls.setup {}

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = "Format",
	desc = "zls",
	pattern = { "*.zig" },
	callback = function() vim.lsp.buf.format() end,
})
