vim.loader.enable()

require('auto-session').setup({
  auto_session_allowed_dirs = { '/etc/nixos' },
  log_level = vim.log.levels.ERROR,
})

require('colorizer').setup({})
if vim.uv.os_getenv('DISPLAY') then
  require('image').setup({ backend = 'ueberzug' })
end

require('nvim-web-devicons').setup({
  override = {
    ['nix'] = { icon = '', color = '#85ea2d', cterm_color = '110', name = 'Nix' },
  },
})

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

require('which-key').setup({
  preset = 'helix',
  sort = { 'alphanum' },
})
require('nvim-surround').setup({})
require('lsp-file-operations').setup({})
require('lsp_signature').setup({
  hint_prefix = '🚀 ',
  floating_window = false,
  close_timeout = 1000,
  -- toggle_key = nil,
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

require('telescope.setup')
require('_init')
require('completion')
require('dap_c')
require('lsp_c')
require('lsp_format')
require('lsp_lua')
require('lualine_c')
require('notify_c')
require('neotest_c')
require('toggleterm_c')
require('treesitter_c')
