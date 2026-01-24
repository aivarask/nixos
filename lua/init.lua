vim.cmd [[
let &runtimepath.=',/etc/nixos'
runtime! lua/{shared,nvim,keymaps,functions}{.vim}
]]
vim.loader.enable()
uv = vim.uv
require 'cf_all'
require 'cf_diagnostic'
require 'cf_lsp'
require 'cf_lualine'
require 'cf_nvim-tree'
require 'cf_telescope'
require 'cf_toggleterm'

vim.keymap.set({ 'n', 'i', 'v' }, '<F1>', require('help').select)
vim.keymap.set({ 'n' }, 'grd', vim.lsp.buf.definition, { desc = 'vim.lsp.buf.definition' })
