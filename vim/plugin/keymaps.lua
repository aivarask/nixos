local complete_snippets = function()
  require('cmp').complete({ config = { sources = { { name = 'luasnip' } } } })
end
vim.keymap.set('i', '<C-b>', complete_snippets)
vim.keymap.set('n', 'qq', require('nvim-tree.api').tree.toggle)
vim.keymap.set({ 'n', 'i' }, '<F2>', vim.lsp.buf.hover, { desc = 'vim.lsp.buf.hover()' })
vim.keymap.set({ 'n', 'i' }, '<F3>', vim.lsp.buf.signature_help, { desc = 'vim.lsp.buf.signature_help()' })
-- vim.keymap.set({ 'n', 'i', 'v' }, '<F4>', function()
--   vim.cmd.help(vim.fn.expand('<cword>'))
-- end, {desc = 'vim.cmd.help(vim.fn.expand("<cword>"))'})

vim.keymap.set('n', '<leader>dw', require('diaglist').open_all_diagnostics)
vim.keymap.set('n', '<leader>d0', require('diaglist').open_buffer_diagnostics)
vim.keymap.set({ 'n' }, '<leader>li', '<cmd>LspInfo<CR>')
vim.keymap.set({ 'n' }, '<leader>lr', '<cmd>LspRestart<CR>')
vim.keymap.set({ 'n', 't', 'i' }, '<F12>', '<cmd>ToggleTerm direction=horizontal<CR>')
vim.keymap.set({ 'n', 't', 'i' }, '<F24>', '<cmd>ToggleTerm direction=vertical<CR>')
vim.keymap.set('n', '<leader>pr', [[:ProjectRoot<CR>]])

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'toggleterm',
  callback = set_terminal_keymaps,
})

