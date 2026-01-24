vim.cmd [[
let &runtimepath.=',/etc/nixos'
source ./shared.vim
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
