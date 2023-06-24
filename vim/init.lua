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

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '.env*',
  callback = function()
    vim.diagnostic.disable()
  end,
})

-- https://github.com/akinsho/toggleterm.nvim
local Terminal = require('toggleterm.terminal').Terminal

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = 'test.prisma,schema.prisma',
  command = 'TermExec open=1 cmd="npx prisma db push && dotenv -e .env.e2e -- npx prisma db push && exit" | LspRestart',
  -- callback = function()   Terminal:new({})  end,
})

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = 'en.json',
  command = 'TermExec open=1 cmd="npx @inlang/cli machine translate -f && exit"',
})
