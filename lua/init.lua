vim.cmd [[
"source $XDG_CONFIG_HOME/nvim/nvimrc.vim
let &runtimepath.=',/etc/nixos'
let &runtimepath.=',/etc/nixos/httpd'
runtime! lua/_config/**/*{.lua,.vim}
runtime! lua/_*{.lua,.vim}
]]
vim.loader.enable()
uv = vim.uv
vim.keymap.set({ 'n', 'i', 'v' }, '<F1>', require('help').select)
vim.keymap.set({ 'n' }, 'grd', vim.lsp.buf.definition, { desc = 'vim.lsp.buf.definition' })
vim.cmd [[
"runtime! */_*{.lua,.vim}
]]
require('gettransfer')
