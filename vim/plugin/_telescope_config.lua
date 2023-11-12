-- https://github.com/nvim-telescope/telescope.nvim
require('telescope').setup({
  defaults = {
    layout_strategy = 'vertical',
    layout_config = {
      vertical = { width = 0.9 },
    },
  },
})
-- https://github.com/nvim-telescope/telescope-fzf-native.nvim
require('telescope').load_extension('fzf')
require('telescope').load_extension('dap')

wkr({
  name = 'Telescope',
  x = {
    function()
      require('telescope.builtin').find_files({ cwd = '/etc/nixos/vim/plugin' })
    end,
    'find_files /etc/nixos/vim/plugin',
  },
  p = { [[:Telescope ak paths<CR>]] },
  c = { '<cmd>Telescope commands<cr>', 'commands' },
  t = { '<cmd>Telescope<cr>', 'Telescope' },
  b = { [[:Telescope buffers <CR>]], 'buffers' },
  k = { [[:Telescope keymaps<CR>]], 'keymaps' },
  h = { [[:Telescope help_tags<CR>]], 'helptags' },
  f = { [[:Telescope find_files<CR>]], 'find_files' },
  g = { [[:Telescope live_grep<CR>]], 'live_grep' },
  l = {
    name = 'LSP',
    d = { [[:Telescope lsp_document_symbols<CR>]], 'lsp_document_symbols' },
    w = { [[:Telescope lsp_workspace_symbols<CR>]], 'lsp_workspace_symbols' },
    x = { [[:Telescope lsp_dynamic_workspace_symbols<CR>]], 'lsp_dynamic_workspace_symbols' },
  },
}, { prefix = '<leader>t' })
