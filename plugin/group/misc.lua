-- symbols-outline-nvim
require('symbols-outline').setup({
  -- autofold_depth = 1,
  lsp_blacklist = { 'null-ls' },
})

-- flatten.nvim flatten-nvim
require("flatten").setup({})

-- glow.nvim glow-nvim
require('glow').setup({
  width = 80,
  height = 100,
  width_ratio = 0.9,
  height_ratio = 0.9,
})

require('neoscroll').setup({ -- neoscroll-nvim
  respect_scrolloff = true,
})
vim.cmd([[
  set scrolloff=8
]])

require('dressing').setup({})          -- dressing-nvim
require('colorizer').setup({})         -- colorizer-nvim
require('nvim-web-devicons').setup({}) -- nvim-dev-icons
