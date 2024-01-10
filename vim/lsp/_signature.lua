require('lsp_signature').setup({
  floating_window = false,
  hint_prefix = '🚀 ',
  hint_inline = function()
    return true
    -- inline | eol
  end,
  close_timeout = 1000,
  toggle_key = '<M-x>',
  select_signature_key = '<M-n>',
})
