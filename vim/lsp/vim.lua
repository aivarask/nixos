local null_ls = require('null-ls')
null_ls.register({
  sources = {
    null_ls.builtins.diagnostics.vint
  },
})

require("lspconfig").vimls.setup({})

