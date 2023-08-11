wkr({
  name = 'Preview, hover',
  f = { require('fold-preview').toggle_preview, 'fold-preview.toggle_preview' },
  d = { require('goto-preview').goto_preview_definition, 'goto_preview_definition' },
  t = { require('goto-preview').goto_preview_type_definition, 'goto_preview_type_definition' },
  i = { require('goto-preview').goto_preview_implementation, 'goto_preview_implementation' },
  r = { require('goto-preview').goto_preview_references, 'goto_preview_references' },
  q = { require('goto-preview').close_all_win, 'goto_preview.close_all_win' },
  K = { require('hover').hover, 'hover-nvim.hover' },
}, { prefix = '?' })
