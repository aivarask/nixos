-- https://github.com/anuvyklack/fold-preview.nvim
-- fold-preview.config
require('fold-preview').setup({
  auto = false,
  default_keybindings = false, -- requires https://github.com/anuvyklack/keymap-amend.nvim
})

-- https://github.com/rmagatti/goto-preview
-- no doc
require('goto-preview').setup({
  -- border = false,
})

-- https://github.com/lewis6991/hover.nvim
require('hover.providers.lsp')

-- https://github.com/anuvyklack/pretty-fold.nvim
require('pretty-fold').setup()

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
