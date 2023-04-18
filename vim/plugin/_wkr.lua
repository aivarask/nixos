wkr({
  ['['] = {
    name = 'Previous',
    t = { require('todo-comments').jump_prev, 'todo-comments.jump_prev' },
  },
  [']'] = {
    name = 'Next',
    t = { require('todo-comments').jump_next, 'todo-comments.jump_next' },
  },
})
