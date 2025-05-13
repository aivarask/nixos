vim.keymap.set({ 'n' }, '<leader>b', function()
	require('telescope.builtin').grep_string()
end, { desc = 'grep_string' })

vim.keymap.set({ 'n' }, '<leader>1', function()
	require "telescope.builtin".live_grep { default_text = vim.fn.expand("<cword>") }
end, { desc = 'live_grep <cword>' })
