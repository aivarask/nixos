require('which-key').register({
  ['-'] = { [[:cd ..<CR>]], 'cd ..' },
  ['<F1>'] = { help_cword, 'help_cword' },
  ['<F13>'] = { help_cWORD, 'help_cWORD' },
  ['<F25>'] = { help_cexpr, 'help_cexpr' },
  -- ['<F2>'] = ../_lsp/~.lua
  -- ['<F3>'] = ../_lsp/~.lua
  ['<F23>'] = {
    "<cmd>exec 'ToggleTerm direction=vertical dir=' .. expand('%:p:h')<CR>",
    'ToggleTerm relative vertical',
    mode = { 'n', 'i', 't' },
  },
  ['<F35>'] = {
    "<cmd>exec 'ToggleTerm direction=tab dir=' .. expand('%:p:h')<CR>",
    'ToggleTerm relative tab',
    mode = { 'n', 'i', 't' },
  },
  ['<F12>'] = {
    '<cmd>ToggleTerm direction=horizontal<CR>',
    'ToggleTerm',
    mode = { 'n', 'i', 't' },
  },
  ['<F24>'] = {
    '<cmd>ToggleTerm direction=vertical<CR>',
    'ToggleTerm',
    mode = { 'n', 'i', 't' },
  },
  ['<F36>'] = {
    '<cmd>ToggleTerm direction=tab<CR>',
    'ToggleTerm',
    mode = { 'n', 'i', 't' },
  },
})
