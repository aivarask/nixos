-- vim.keymap.set({ 'n' }, '<leader>b', function()
-- 	require('telescope.builtin').grep_string({ grep_open_files = false })
-- end, { desc = 'grep_string' })

vim.keymap.set({ 'n' }, '<leader>1', function()
	require "telescope.builtin".live_grep { default_text = vim.fn.expand("<cword>") }
end, { desc = 'live_grep <cword>' })

vim.keymap.set({ 'n', 'v', 'i' }, "<C-Tab>", "<cmd>bnext<cr>")
vim.keymap.set({ 'v', 'i' }, "<C-R>", "<cmd>Telescope registers<cr>")
vim.keymap.set({ 'n', 'x' }, "]]", "<cmd>:bnext<cr>")
vim.keymap.set({ 'n', 'x' }, "[[", "<cmd>:bprevious<cr>")
