local null_ls = require('null-ls')
null_ls.register({
  null_ls.builtins.formatting.prettier.with(),
})

require('lspconfig').tsserver.setup({})
