-- https://github.com/aca/emmet-ls
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#emmet_ls
require('lspconfig').emmet_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = function()
    return vim.loop.cwd()
  end,
  init_options = {
    ['bem.enabled'] = true,
  },
})


