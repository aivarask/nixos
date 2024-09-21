vim.loader.enable()

vim.filetype.add({
  filename = {
    ['.prettierrc'] = 'json',
  },
})

require('auto-session').setup({ --- @see AutoSession
  log_level = vim.log.levels.ERROR,
  auto_session_allowed_dirs = { '/etc/nixos' },
})
require('colorizer').setup({})
if vim.uv.os_getenv('DISPLAY') then
  require('image').setup({ backend = 'ueberzug' })
end
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
local wk = require('which-key')
wk.setup({
  preset = 'helix',
  sort = { 'alphanum' },
})

require('lsp-file-operations').setup({})
require('lsp_signature').setup({

  floating_window = false,
  close_timeout = 1000,
  hint_prefix = '🚀 ',
  toggle_key = '<M-k>',
})
require('hover').setup({
  init = function()
    require('hover.providers.lsp')
  end,
})
require('outline').setup({
  symbols = {
    icons = {
      Class = { icon = '󰠱', hl = 'Type' },
      String = { icon = '󰉿', hl = 'String' },
      Struct = { icon = '󰙅', hl = 'Structure' },
      Event = { icon = '', hl = 'Type' },
      TypeParameter = { icon = 'T', hl = 'Identifier' },
    },
  },
})

require('notif')
require('dapl')
require('ls')
require('completion')
require('open')
