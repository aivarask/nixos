-- https://github.com/folke/trouble.nvim
require('trouble').setup({})

-- https://github.com/folke/todo-comments.nvim
require('todo-comments').setup({})

wkr({
  name = 'Trouble',
  x = { '[[:TroubleToggle<CR>]]', 'TroubleToggle' },
}, { prefix = '<leader>x' })
