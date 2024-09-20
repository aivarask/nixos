vim.loader.enable()


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
require('iron.core').setup({
  config = {
    repl_definition = {
      -- lua = require "iron.fts.lua",
      sh = { command = { 'zsh' } },
    },
    repl_open_cmd = require('iron.view').right('40%'),
  },
  keymaps = {
    -- send_line = "<M-s>",
  },
})

require('notif')
require('dapl')
require('ls')
require('completion')
require('open')
