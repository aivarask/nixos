-- https://github.com/simrat39/symbols-outline.nvim
-- symbols-outline-configuration
require('symbols-outline').setup({
  -- autofold_depth = 1,
  lsp_blacklist = { 'null-ls' },
})

require('lsp_signature').setup({
  -- lsp_signature-configure
  floating_window = false,
  close_timeout = 1000,
  hint_prefix = '🚀 ',
  toggle_key = '<M-x>',
})
