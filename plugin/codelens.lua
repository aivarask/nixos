require('goto-preview').setup({}) -- goto-preview

-- hover-nvim
require('hover').setup({
  init = function()
    require('hover.providers.lsp')
  end,
})
require('pretty-fold').setup()  -- pretty-fold-nvim

require('fold-preview').setup({ -- fold-preview-nvim
  auto = 400,
  default_keybindings = false,
})

wk.add({
  { 'gp', group = 'goto-preview', icon = '🔍' },
  { 'gpf', require('fold-preview').toggle_preview, desc = 'fold-preview.toggle_preview' },
  { 'gpd', require('goto-preview').goto_preview_definition, desc = 'definition' },
  { 'gpt', require('goto-preview').goto_preview_type_definition, desc = 'type_definition' },
  { 'gpi', require('goto-preview').goto_preview_implementation, desc = 'implementation' },
  { 'gpD', require('goto-preview').goto_preview_declaration, desc = 'declaration' },
  { 'gpc', require('goto-preview').close_all_win, desc = 'close_all_win' },
  { 'gpr', require('goto-preview').goto_preview_references, desc = 'references' },
})
