local null_ls = require('null-ls')
null_ls.register({
  null_ls.builtins.formatting.prettier.with({
    extra_filetypes = { 'svelte' },
  }),
})

require('lspconfig').svelte.setup({})
