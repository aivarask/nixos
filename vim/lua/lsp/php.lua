-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#psalm
-- https://akrabat.com/global-installation-of-php-tools-with-composer/
-- "phpactor", -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#phpactor

require("lspconfig").psalm.setup({
  capabilities = require("capabilities"),
  on_attach = require("on_attach"),
})
