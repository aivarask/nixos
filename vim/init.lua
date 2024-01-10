vim.cmd([[
 source /etc/nixos/vim/vimrc.vim
]])

vim.loader.enable()
require('which-key').setup({})
wkr = require('which-key').register

require('lsp._null')
require('lsp._signature')
require('lsp.go')
require('lsp.json')
require('lsp.lua')
require('lsp.make')
require('lsp.nix')
require('lsp.svelte')
require('lsp.toml')
require('lsp.vim')
require('lsp.yaml')
