vim.cmd [[
"source $XDG_CONFIG_HOME/nvim/nvimrc.vim
let &runtimepath.=',/etc/nixos'
let &packpath.=',/etc/nixos'
runtime! lua/cfg/**/*{.lua,.vim}
runtime! lua/_*{.lua,.vim}
]]
vim.loader.enable()
require('help')
