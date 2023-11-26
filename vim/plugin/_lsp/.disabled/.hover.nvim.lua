  -- K = { require('hover').hover, 'hover-nvim.hover' },
-- https://github.com/lewis6991/hover.nvim/
require('hover').setup({
  init = function()
    require('hover.providers.lsp')
  end,
  preview_opts = { border = nil },
  preview_window = false,
  title = true,
})

