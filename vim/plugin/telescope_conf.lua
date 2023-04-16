require('telescope').setup({ -- https://github.com/nvim-telescope/telescope.nvim
  defaults = {
    layout_strategy = 'vertical',
    layout_config = {
      vertical = { width = 0.9 },
    },
  },
  extensions = {
    fzf = {
      -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
})
-- https://github.com/folke/trouble.nvim#telescope
require('telescope').load_extension('fzf')
require('telescope').load_extension('projects')
