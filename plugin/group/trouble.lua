require('trouble').setup({})       -- trouble-nvim
require('todo-comments').setup({}) -- todo-comments-nvim

require('which-key').register({
  ['[t'] = { require('todo-comments').jump_prev, 'todo-comments' },
  [']t'] = { require('todo-comments').jump_next, 'todo-comments' },
})

require('which-key').register({
  name = 'Trouble',
  x = { '[[:TroubleToggle<CR>]]', 'TroubleToggle' },
}, { prefix = '<leader>x' })
