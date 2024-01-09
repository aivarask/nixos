-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#cssmodules_ls
-- https://github.com/antonk52/cssmodules-language-server
require('lspconfig').cssmodules_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'svelte' },
})


