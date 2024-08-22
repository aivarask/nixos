local ftmap = require("null-ls.builtins._meta.filetype_map").vim
local vim = {
	diagnostics = { "vint" },
}

-- require('null-ls').register({
--   require('null-ls.builtins.diagnostics.vint'),
-- })

local vimls = require "lspconfig.server_configurations.vimls"
require("lspconfig").vimls.setup {}

-- vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
--   group = 'Format',
--   desc = 'vimls',
--   pattern = { '*.vim' },
--   callback = function() vim.lsp.buf.format({}) end,
-- })
