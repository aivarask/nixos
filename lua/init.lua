vim.cmd [[
"source $XDG_CONFIG_HOME/nvim/nvimrc.vim
let &runtimepath.=',/etc/nixos'
runtime! lua/_config/**/*{.lua,.vim}
runtime! lua/_*{.lua,.vim}
]]
vim.loader.enable()

vim.keymap.set({ 'n', 'i', 'v' }, '<F1>', require('help').select)
-- vim.keymap.set({ 'n', 'i', 'v' }, '<F2>', vim.lsp.buf.signature_help)
-- vim.keymap.set('i', '<C-n>', function()
--   return vim.fn.pumvisible() == 1 and "<C-n>" or "<C-x><C-o>"
-- end, { expr = true })
