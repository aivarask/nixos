-- symbols-outline-configuration symbols-outline-nvim
require('symbols-outline').setup({
  -- autofold_depth = 1,
  lsp_blacklist = { 'null-ls' },
})

-- flatten.nvim flatten-nvim
require("flatten").setup({
  -- your config
})

-- glow.nvim glow-nvim
require('glow').setup({
  width = 80,
  height = 100,
  width_ratio = 0.9,
  height_ratio = 0.9,
})
