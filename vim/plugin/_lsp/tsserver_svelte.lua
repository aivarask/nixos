local null_ls = require('null-ls')
null_ls.register({
  require('typescript.extensions.null-ls.code-actions'),
  null_ls.builtins.formatting.prettier.with({
    extra_filetypes = { 'svelte' },
  }),
})
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#svelte
require('lspconfig').tsserver.setup({})

-- https://github.com/sveltejs/language-tools/tree/master/packages/typescript-plugin
require('lspconfig').svelte.setup({})
