vim.cmd([[
 source /etc/nixos/vim/vimrc.vim
]])

vim.api.nvim_clear_autocmds({})
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function()
    vim.schedule(vim.lsp.buf.format)
  end,
})

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = 'test.prisma,schema.prisma',
  command = 'TermExec cmd="npx prisma db push"',
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '.env*',
  callback = function()
    vim.diagnostic.disable()
  end,
})
