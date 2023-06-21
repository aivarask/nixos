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

local Terminal = require('toggleterm.terminal').Terminal
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = 'test.prisma,schema.prisma',
  command = 'TermExec open=1 cmd="npx prisma db push && dotenv -e .env.e2e -- npx prisma db push" | LspRestart',
  -- callback = function()   Terminal:new({})  end,
})

-- local lazygit = Terminal:new({
--   cmd = 'lazygit',
--   dir = 'git_dir',
--   direction = 'float',
--   float_opts = {
--     border = 'double',
--   },
--   -- function to run on opening the terminal
--   on_open = function(term)
--     vim.cmd('startinsert!')
--     vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
--   end,
--   -- function to run on closing the terminal
--   on_close = function(term)
--     vim.cmd('startinsert!')
--   end,
-- })

-- function _lazygit_toggle()
--   lazygit:toggle()
-- end

-- vim.api.nvim_set_keymap('n', '<leader>lg', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true })
