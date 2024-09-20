require('telescope').setup({
  defaults = {
    layout_strategy = 'vertical',
    layout_config = { vertical = { width = 0.9 } },
  },
})

local wk = require('which-key')
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
