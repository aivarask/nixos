-- https://github.com/nvimtools/none-ls.nvim
local null_ls = require('null-ls')
null_ls.register({
  -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md#php
  -- null_ls.builtins.diagnostics.php,
  -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md#phpcs
  -- null_ls.builtins.diagnostics.phpcs,
  -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md#phpmd
  -- null_ls.builtins.diagnostics.phpmd,
  -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md#phpstan
  -- null_ls.builtins.diagnostics.phpstan,
  -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md#psalm
  -- null_ls.builtins.diagnostics.psalm,

  -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md#phpcbf
  -- null_ls.builtins.formatting.phpcbf,
  -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md#phpcsfixer
  -- null_ls.builtins.formatting.phpcsfixer,
  -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md#pint
  -- null_ls.builtins.formatting.pint,
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#intelephense
require('lspconfig').intelephense.setup({
  root_dir = require('lspconfig.util').root_pattern('composer.json', '.git', 'index.php'),
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#phan
-- require('lspconfig').phan.setup({})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#phpactor
-- require('lspconfig').phpactor.setup({})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#psalm
-- require('lspconfig').psalm.setup({})
