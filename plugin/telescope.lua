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

wk.add({
  { '[t', require('todo-comments').jump_prev, desc = 'todo prev' },
  { ']t', require('todo-comments').jump_next, desc = 'todo next' },
})

local find_files = require('telescope.builtin').find_files

wk.add({
  { '<leader>t',   group = 'Telescope' },
  { '<leader>ta',  [[:Telescope autocommands<CR>]],                            desc = 'autocommands' },
  { '<leader>tB',  [[:Telescope buffers <CR>]],                                desc = 'buffers' },
  { '<leader>tc',  [[:Telescope commands<cr> ]],                               desc = 'commands' },
  { '<leader>te',  [[:Telescope symbols<cr> ]],                                desc = 'emoji symbols' },
  { '<leader>tf',  [[:Telescope find_files<CR>]],                              desc = 'find_files' },
  { '<leader>tg',  [[:Telescope live_grep<CR>]],                               desc = 'live_grep' },
  { '<leader>th',  [[:Telescope help_tags<CR>]],                               desc = 'helptags' },
  { '<leader>tk',  [[:Telescope keymaps<CR>]],                                 desc = 'keymaps' },
  { '<leader>tn',  function() find_files({ cwd = '/etc/nixos' }) end,          desc = 'find /etc/nixos' },
  { '<leader>tp',  [[:Telescope ak paths<CR>]],                                desc = 'ak paths' },
  { '<leader>tr',  [[:Telescope registers<CR>]],                               desc = 'registers' },
  { '<leader>ts',  function() find_files({ cwd = '/etc/nixos/snippets' }) end, desc = 'find snippets' },
  { '<leader>tt',  [[:Telescope<CR>]],                                         desc = 'Telescope' },
  { '<leader>tx',  '[[:TroubleToggle<CR>]]',                                   desc = 'TroubleToggle' },
  { '<leader>tld', [[:Telescope lsp_document_symbols<CR>]],                    desc = 'lsp_document_symbols' },
  { '<leader>tlw', [[:Telescope lsp_workspace_symbols<CR>]],                   desc = 'lsp_workspace_symbols' },
  { '<leader>tlx', [[:Telescope lsp_dynamic_workspace_symbols<CR>]],           desc = 'lsp_dynamic_workspace_symbols' },
})
