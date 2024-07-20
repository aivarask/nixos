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

wk.add({
  { '<leader>t',  group = 'Telescope' },
  { '<leader>ta', [[:Telescope autocommands<CR>]],                            desc = 'autocommands' },
  { '<leader>tb', [[:Telescope buffers <CR>]],                                desc = 'buffers' },
  { '<leader>tc', [[:Telescope commands<cr> ]],                               desc = 'commands' },
  { '<leader>te', [[:Telescope symbols<cr> ]],                                desc = 'emoji symbols' },
  { '<leader>tf', [[:Telescope find_files<CR>]],                              desc = 'find_files' },
  { '<leader>tg', [[:Telescope live_grep<CR>]],                               desc = 'live_grep' },
  { '<leader>th', [[:Telescope help_tags<CR>]],                               desc = 'helptags' },
  { '<leader>tk', [[:Telescope keymaps<CR>]],                                 desc = 'keymaps' },
  { '<leader>tn', function() find_files({ cwd = '/etc/nixos' }) end,          desc = 'find /etc/nixos' },
  { '<leader>tp', [[:Telescope ak paths<CR>]],                                desc = 'ak paths' },
  { '<leader>tr', [[:Telescope registers<CR>]],                               desc = 'registers' },
  { '<leader>ts', function() find_files({ cwd = '/etc/nixos/snippets' }) end, desc = 'find snippets' },
  { '<leader>tt', [[:Telescope<CR>]],                                         desc = 'Telescope' },
  { '<leader>tx', '[[:TroubleToggle<CR>]]',                                   desc = 'TroubleToggle' },
  -- l = {
  --   name = 'LSP',
  --   d = { [[:Telescope lsp_document_symbols<CR>]], 'lsp_document_symbols' },
  --   w = { [[:Telescope lsp_workspace_symbols<CR>]], 'lsp_workspace_symbols' },
  --   x = { [[:Telescope lsp_dynamic_workspace_symbols<CR>]], 'lsp_dynamic_workspace_symbols' },
  -- },
})
