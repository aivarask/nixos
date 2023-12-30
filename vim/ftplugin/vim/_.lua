local null_ls = require('null-ls')
null_ls.register({
  sources = {
    -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md#vint
    null_ls.builtins.diagnostics.vint,
  },
})
