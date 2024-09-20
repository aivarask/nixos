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

require('telescope').setup({
  defaults = {
    layout_strategy = 'vertical',
    layout_config = { vertical = { width = 0.9 } },
  },
})

wk.add({
  { '<leader>t', group = 'Telescope', icon = '' },
  { '<leader>ta', [[:Telescope autocommands<CR>]] },
  { '<leader>tB', [[:Telescope buffers <CR>]] },
  { '<leader>tc', [[:Telescope commands<cr>]] },
  { '<leader>tf', [[:Telescope find_files<cr>]] },
  { '<leader>tg', [[:Telescope live_grep<CR>]] },
  { '<leader>th', [[:Telescope help_tags<CR>]] },
  { '<leader>tk', [[:Telescope keymaps<CR>]] },
  { '<leader>tm', [[:Telescope manix<CR>]] },
  { '<leader>tn', [[:Telescope notify<CR>]] },
  { '<leader>to', [[:Telescope vim_options<CR>]] },
  { '<leader>tp', [[:Telescope paths<CR>]] },
  { '<leader>tr', [[:Telescope registers<CR>]] },
  { '<leader>ts', [[:Telescope session-lens<CR>]] },
  { '<leader>tS', [[:Telescope snippets<CR>]] },
  { '<leader>tt', [[:Telescope<CR>]] },
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
