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
