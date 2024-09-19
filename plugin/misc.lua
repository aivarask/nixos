require('colorizer').setup({})

if vim.uv.os_getenv('DISPLAY') then require('image').setup({ backend = 'ueberzug' }) end
require('nvim-tree').setup({
  view = { width = 25, signcolumn = 'no' },
  git = { enable = false },
  sync_root_with_cwd = true,
  update_focused_file = { enable = true, update_root = true },
  ui = { confirm = { trash = false } },
  on_attach = function(bufnr)
    local api = require('nvim-tree.api')
    api.config.mappings.default_on_attach(bufnr)
  end,
})
