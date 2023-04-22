wkr({
  ['['] = {
    name = 'Previous',
    t = { require('todo-comments').jump_prev, 'todo-comments.jump_prev' },
    d = { vim.diagnostic.goto_prev, 'vim.diagnostic.goto_prev' },
  },
  [']'] = {
    name = 'Next',
    t = { require('todo-comments').jump_next, 'todo-comments.jump_next' },
    d = { vim.diagnostic.goto_next, 'vim.diagnostic.goto_next' },
  },
})
