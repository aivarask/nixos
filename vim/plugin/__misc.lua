-- https://github.com/airblade/vim-gitgutter
-- https://github.com/lewis6991/gitsigns.nvim
-- require('gitsigns').setup({})

-- https://github.com/anuvyklack/pretty-fold.nvim
require('pretty-fold').setup()

-- https://github.com/akinsho/toggleterm.nvim#setup
require('toggleterm').setup({
  shade_terminals = false,
  size = function(term)
    if term.direction == 'horizontal' then
      return vim.o.lines * 0.2
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.3
    elseif term.direction == 'float' then
      return vim.o.columns * 0.6
    end
  end,
  float_opts = {
    height = 50,
  },
})
-- https://github.com/lukas-reineke/indent-blankline.nvim
require('indent_blankline').setup({
  show_current_context = true,
  show_current_context_start = true,
})
require('symbols-outline').setup({})
-- https://github.com/nvim-tree/nvim-web-devicons
require('nvim-web-devicons').setup()
-- https://github.com/norcalli/nvim-colorizer.lua
require('colorizer').setup()
-- https://github.co/onsails/diaglist.nvim
require('diaglist').init()
-- https://github.com/karb94/neoscroll.nvim
require('neoscroll').setup()
