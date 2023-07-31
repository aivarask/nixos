-- https://github.com/akinsho/toggleterm.nvim
local Terminal = require('toggleterm.terminal').Terminal

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = 'schema.prisma',
  command = 'TermExec open=1 cmd="npx prisma db push && dotenv -e .env.e2e -- npx prisma db push && exit" | LspRestart',
})

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = { 'en.json', 'en.yml' },
  command = 'TermExec open=1 cmd="npx @inlang/cli machine translate -f && exit"',
})
