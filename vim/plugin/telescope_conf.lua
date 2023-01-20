vim.keymap.set({ 'n', 'i', 'v' }, '<F5>', '<cmd>Telescope keymaps<CR>')
vim.keymap.set('n', '<leader>tk', [[:Telescope keymaps<CR>]])
vim.keymap.set('n', '<leader>tp', [[:Telescope projects<CR>]])
vim.keymap.set('n', '<leader>th', [[:Telescope help_tags<CR>]])
vim.keymap.set('n', '<leader>ds', [[:Telescope lsp_document_symbols<CR>]])
vim.keymap.set('n', '<leader>ws', [[:Telescope lsp_workspace_symbols<CR>]])
vim.keymap.set('n', '<leader>dws', [[:Telescope lsp_dynamic_workspace_symbols<CR>]])

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

-- TODO: telescope dap integration
-- nvim-telescope/telescope-dap.nvim
require('telescope').load_extension('dap')
vim.keymap.set('n', '<leader>tdf', ':Telescope dap frames<CR>')
-- map('n', '<leader>dc', ':Telescope dap commands<CR>')
vim.keymap.set('n', '<leader>tlb', ':Telescope dap list_breakpoints<CR>')
vim.keymap.set('n', '<leader>tdb', ':lua require"dap".step_back()<CR>')
