todo = require 'todo-comments'
todo.setup {}
wk.add {
  { '<leader>c',  group = 'todo-comments', },
  { '<leader>c[', todo.jump_prev,         desc = 'jump_prev', },
  { '<leader>c]', todo.jump_next,         desc = 'jump_next', },
  { '<leader>cc', '<cmd>TodoTrouble<CR>', },
  { '<leader>cd', todo.disable,           desc = 'disable', },
  { '<leader>ce', todo.enable,            desc = 'enable', },
  -- { '<leader>cl', '<cmd>TodoLocList<CR>' },
  { '<leader>cq', '<cmd>TodoQuickFix<CR>', },
}

require 'telescope'.setup { defaults = { layout_strategy = 'vertical', layout_config = { vertical = { width = 0.9, }, }, }, }
require 'telescope'.load_extension 'dap'
require 'telescope'.load_extension 'fzf'
local ff = require 'telescope.builtin'.find_files
wk.add {
  { '<leader>t',   group = 'Telescope', },
  { '<leader>ta',  [[:Telescope autocommands<CR>]],                   desc = 'autocommands', },
  { '<leader>tB',  [[:Telescope buffers <CR>]],                       desc = 'buffers', },
  { '<leader>tc',  [[:Telescope commands<cr> ]],                      desc = 'commands', },
  { '<leader>tg',  [[:Telescope live_grep<CR>]],                      desc = 'live_grep', },
  { '<leader>th',  [[:Telescope help_tags<CR>]],                      desc = 'helptags', },
  { '<leader>tk',  [[:Telescope keymaps<CR>]],                        desc = 'keymaps', },
  { '<leader>tl',  group = 'LSP', },
  { '<leader>tld', [[:Telescope lsp_document_symbols<CR>]],           desc = 'lsp_document_symbols', },
  { '<leader>tlw', [[:Telescope lsp_workspace_symbols<CR>]],          desc = 'lsp_workspace_symbols', },
  { '<leader>tlx', [[:Telescope lsp_dynamic_workspace_symbols<CR>]],  desc = 'lsp_dynamic_workspace_symbols', },
  { '<leader>tn',  function() ff { cwd = '/etc/nixos', } end,         desc = 'find /etc/nixos', },
  { '<leader>tp',  [[:Telescope ak paths<CR>]],                       desc = 'ak paths', },
  { '<leader>tr',  [[:Telescope registers<CR>]],                      desc = 'registers', },
  { '<leader>ts',  function() ff { cwd = '/etc/nixos/snippets', } end, desc = 'find snippets', },
  { '<leader>tt',  [[:Telescope<CR>]],                                desc = 'Telescope', },
}

trouble = require 'trouble'
trouble.setup {}
wk.add {
  { '<leader>x',  group = 'Trouble', },
  { '<leader>xb', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',           desc = 'diagnostics %', },
  { '<leader>xc', '<cmd>Trouble todo toggle<cr>',                               desc = 'todo-comments', },
  { '<leader>xd', '<cmd>Trouble diagnostics toggle<cr>',                        desc = 'diagnostics', },
  { '<leader>xL', '<cmd>Trouble loclist toggle<cr>',                            desc = 'loclist', },
  { '<leader>xl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', desc = 'lsp', }, -- TODO: err no results for lsp, sounds interesting
  { '<leader>xq', '<cmd>Trouble qflist toggle<cr>',                             desc = 'qflist', },
  { '<leader>xs', '<cmd>Trouble symbols toggle focus=false<cr>',                desc = 'symbols', },
  { '<leader>xx', '<cmd>Trouble<cr>',                                           desc = 'Trouble', },
}
