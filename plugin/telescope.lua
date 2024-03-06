require('telescope').setup({ -- telescope-nvim
  defaults = {
    layout_strategy = 'vertical',
    layout_config = {
      vertical = { width = 0.9 },
    },
  },
})
require('telescope').load_extension('fzf')
require('telescope').load_extension('dap')
require('trouble').setup({})       -- trouble-nvim
require('todo-comments').setup({}) -- todo-comments-nvim

require('which-key').register({
  ['[t'] = { require('todo-comments').jump_prev, 'todo-comments' },
  [']t'] = { require('todo-comments').jump_next, 'todo-comments' },
})

local find_files = require('telescope.builtin').find_files

require('which-key').register({
  name = 'Telescope',
  a = { [[:Telescope autocommands<CR>]], 'autocommands' },
  b = { [[:Telescope buffers <CR>]], 'buffers' },
  c = { [[:Telescope commands<cr> ]], 'commands' },
  e = { [[:Telescope symbols<cr> ]], 'emoji symbols' },
  f = { [[:Telescope find_files<CR>]], 'find_files' },
  g = { [[:Telescope live_grep<CR>]], 'live_grep' },
  h = { [[:Telescope help_tags<CR>]], 'helptags' },
  k = { [[:Telescope keymaps<CR>]], 'keymaps' },
  n = { function() find_files({ cwd = '/etc/nixos' }) end, 'find /etc/nixos' },
  p = { [[:Telescope ak paths<CR>]], 'ak paths' },
  r = { [[:Telescope registers<CR>]], 'registers' },
  s = { function() find_files({ cwd = '/etc/nixos/snippets' }) end, 'find snippets' },
  t = { [[:Telescope<CR>]], 'Telescope' },
  l = {
    name = 'LSP',
    d = { [[:Telescope lsp_document_symbols<CR>]], 'lsp_document_symbols' },
    w = { [[:Telescope lsp_workspace_symbols<CR>]], 'lsp_workspace_symbols' },
    x = { [[:Telescope lsp_dynamic_workspace_symbols<CR>]], 'lsp_dynamic_workspace_symbols' },
  },
  x = { '[[:TroubleToggle<CR>]]', 'TroubleToggle' },
}, { prefix = '<leader>t' })
