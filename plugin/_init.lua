vim.loader.enable()

require('auto-session').setup({ --- @see AutoSession
  auto_session_allowed_dirs = { '/etc/nixos' },
  log_level = vim.log.levels.ERROR,
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
    require('nvim-tree.api').config.mappings.default_on_attach(bufnr)
  end,
})
require('nvim-web-devicons').setup({
  override = {
    ['nix'] = { icon = '', color = '#85ea2d', cterm_color = '110', name = 'Nix' },
  },
})

require('which-key').setup({
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

require('_aug')
require('_init')
require('completion')
require('dap_config')
require('lsp_config')
require('lsp_format')
require('lsp_lua')
require('notify_config')
