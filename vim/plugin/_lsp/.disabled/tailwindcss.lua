-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tailwindcss
require('lspconfig').tailwindcss.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  -- https://github.com/tailwindlabs/tailwindcss-intellisense#extension-settings
  settings = {
    tailwindCSS = {
      emmetCompletions = true,
      classAttributes = {
        'class',
        'class:',
        'className',
        'classWrap',
        'classInput',
        'classText',
        'classAvatar',
        'classList',
        'divClass',
        'navClass',
        'navDivClass',
        'ulClass',
      },
      validate = true,
    },
  },
})


