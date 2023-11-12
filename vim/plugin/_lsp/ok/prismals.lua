-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#prismals
require('lspconfig').prismals.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})


