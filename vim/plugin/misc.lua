-- https://github.com/anuvyklack/pretty-fold.nvim
require('pretty-fold').setup()

-- https://github.com/anuvyklack/fold-preview.nvim
local fp = require('fold-preview')
fp.setup({
  auto = false,
  default_keybindings = false,
})

-- https://github.com/lukas-reineke/indent-blankline.nvim
require('ibl').setup({
  -- show_current_context = true,
  -- show_current_context_start = true,
})
-- https://github.com/simrat39/symbols-outline.nvim
require('symbols-outline').setup({
  lsp_blacklist = { 'null-ls' },
})
-- https://github.com/nvim-tree/nvim-web-devicons
require('nvim-web-devicons').setup()
-- https://github.com/norcalli/nvim-colorizer.lua
require('colorizer').setup()
-- https://github.com/onsails/diaglist.nvim
require('diaglist').init()
-- https://github.com/karb94/neoscroll.nvim#features
require('neoscroll').setup()
