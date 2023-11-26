local null_ls = require('null-ls')

null_ls.register({
  null_ls.builtins.formatting.shellharden,
  null_ls.builtins.formatting.shfmt.with({
    filetypes = { 'sh', 'zsh' },
    command = 'shfmt',
    args = { '-filename', '$FILENAME' },
    extra_args = { '-i', '2', '-ci' },
  }),
  null_ls.builtins.diagnostics.zsh,
})
