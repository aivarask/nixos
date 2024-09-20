local todo = require('todo-comments')
todo.setup({})

local wk = require('which-key')
wk.add({
  { '<leader>c', group = 'todo-comments' },
  { '<leader>c[', todo.jump_prev, desc = 'jump_prev' },
  { '<leader>c]', todo.jump_next, desc = 'jump_next' },
  { '<leader>cc', '<cmd>TodoTrouble<CR>' },
  { '<leader>cd', todo.disable, desc = 'disable' },
  { '<leader>ce', todo.enable, desc = 'enable' },
  -- { '<leader>cl', '<cmd>TodoLocList<CR>' },
  { '<leader>cq', '<cmd>TodoQuickFix<CR>' },
})

trouble = require('trouble')
trouble.setup({})
wk.add({
  { '<leader>x', group = 'Trouble' },
  { '<leader>xb', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>' },
  { '<leader>xc', '<cmd>Trouble todo toggle<cr>' },
  { '<leader>xd', '<cmd>Trouble diagnostics toggle<cr>' },
  { '<leader>xL', '<cmd>Trouble loclist toggle<cr>' },
  { '<leader>xl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>' },
  { '<leader>xq', '<cmd>Trouble qflist toggle<cr>' },
  { '<leader>xs', '<cmd>Trouble symbols toggle focus=false<cr>' },
  { '<leader>xx', [[:Trouble<cr>]] },
})
