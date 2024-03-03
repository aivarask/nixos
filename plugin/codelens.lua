require('goto-preview').setup({}) -- goto-preview

-- hover-nvim
require('hover').setup({
  init = function()
    require('hover.providers.lsp')
  end,
})
require('pretty-fold').setup()  -- pretty-fold-nvim

require('fold-preview').setup({ -- fold-preview-nvim
  auto = false,
  default_keybindings = false,
})

require('which-key').register({
  name = 'Preview',
  gpf = { require('fold-preview').toggle_preview, 'fold-preview.toggle_preview' },
  gpd = { require('goto-preview').goto_preview_definition, 'definition' },
  gpt = { require('goto-preview').goto_preview_type_definition, 'type_definition' },
  gpi = { require('goto-preview').goto_preview_implementation, 'implementation' },
  gpD = { require('goto-preview').goto_preview_declaration, 'declaration' },
  gpc = { require('goto-preview').close_all_win, 'close_all_win' },
  gpr = { require('goto-preview').goto_preview_references, 'references' },
})
