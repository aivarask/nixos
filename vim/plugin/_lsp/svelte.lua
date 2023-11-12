-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#svelte
-- https://github.com/sveltejs/language-tools/tree/master/packages/typescript-plugin
require('lspconfig').svelte.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
