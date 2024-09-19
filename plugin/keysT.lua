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
  -- mappings = {
  -- 	i = {
  -- 		-- map actions.which_key to <C-h> (default: <C-/>)
  -- 		-- actions.which_key shows the mappings for your picker,
  -- 		-- e.g. git_{create, delete, ...}_branch for the git_branches picker
  -- 		["<C-h>"] = "live_grep",
  -- 	},
  -- },
})
require('telescope').load_extension('fzf')
require('telescope').load_extension('manix')
local ff = require('telescope.builtin').find_files
wk.add({
  { '<leader>t', group = 'Telescope' },
  { '<leader>ta', [[:Telescope autocommands<CR>]] },
  { '<leader>tB', [[:Telescope buffers <CR>]] },
  { '<leader>tc', [[:Telescope commands<cr>]] },
  { '<leader>td', [[:Telescope dap ]] },
  { '<leader>tf', [[:Telescope find_files<cr>]] },
  { '<leader>tg', [[:Telescope live_grep<CR>]] },
  { '<leader>th', [[:Telescope help_tags<CR>]] },
  { '<leader>tk', [[:Telescope keymaps<CR>]] },
  { '<leader>tl', group = 'LSP' },
  { '<leader>tld', [[:Telescope lsp_document_symbols<CR>]] },
  { '<leader>tlw', [[:Telescope lsp_workspace_symbols<CR>]] },
  { '<leader>tlx', [[:Telescope lsp_dynamic_workspace_symbols<CR>]] },
  { '<leader>tm', [[:Telescope manix<CR>]] },
  { '<leader>tn', [[:Telescope notify<CR>]] },
  {
    '<leader>tN',
    function() ff({ cwd = '/etc/nixos' }) end,
    desc = 'find /etc/nixos',
  },
  { '<leader>to', [[:Telescope vim_options<CR>]] },
  { '<leader>tp', [[:Telescope ak paths<CR>]] },
  { '<leader>tr', [[:Telescope registers<CR>]] },
  { '<leader>ts', [[:Telescope session-lens<CR>]] },
  {
    '<leader>tS',
    function() ff({ cwd = '/etc/nixos/snippets' }) end,
    desc = 'find /etc/nixos/snippets',
  },
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
