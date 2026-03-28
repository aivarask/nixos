-- let &runtimepath.=',/etc/nixos'
vim.cmd [[
runtime! lua/*{.vim}
]]
vim.loader.enable()
uv = vim.uv
require 'cf_all'
require 'cf_diagnostic'
require 'cf_lsp'
require 'cf_lsp_attach'
require 'cf_lualine'
require 'cf_nvim-tree'
require 'cf_telescope'

vim.keymap.set({ 'n', 'i', 'v' }, '<F1>', require('help').select)

local toggleterm = require('toggleterm')
toggleterm.setup({
	shade_terminals = false,
	size = function(term)
		return term.direction == 'horizontal' and vim.o.lines * 0.4
		    or (term.direction == 'vertical' and vim.o.columns * 0.3)
	end,
	float_opts = {
		width = function() return math.ceil(vim.o.columns * 0.9) end,
		height = function() return math.ceil(vim.o.lines * 0.9) end,
	},
})
