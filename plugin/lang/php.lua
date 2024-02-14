-- https://github.com/nvimtools/none-ls.nvim
local null_ls = require('null-ls')
null_ls.register({
  -- null_ls.builtins.diagnostics.php,
  -- null_ls.builtins.diagnostics.phpcs,
  -- null_ls.builtins.diagnostics.phpmd,
  -- null_ls.builtins.diagnostics.phpstan,
  -- null_ls.builtins.diagnostics.psalm,
  -- null_ls.builtins.formatting.phpcbf,
  -- null_ls.builtins.formatting.phpcsfixer,
  -- null_ls.builtins.formatting.pint,
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#intelephense
require('lspconfig').intelephense.setup({
  root_dir = require('lspconfig.util').root_pattern('composer.json', '.git', 'index.php'),
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*.php' },
  callback = function() vim.lsp.buf.format({ filter = function(client) return client.name == 'intelephense' end }) end,
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#phan
-- require('lspconfig').phan.setup({})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#phpactor
-- require('lspconfig').phpactor.setup({})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#psalm
-- require('lspconfig').psalm.setup({})

require('which-key').register({
  n = { function()
    vim.cmd(
      [[!nix eval nixos\#nixosConfigurations.]]
      .. vim.uv.os_gethostname()
      .. '.pkgs.nodePackages.'
      .. vim.fn.expand('<cword>')
      .. '.meta.homepage | xargs xdg-open'
    )
  end, 'nodePackages' },
  p = { function()
    vim.cmd(
      [[!nix eval nixos\#nixosConfigurations.]]
      .. vim.uv.os_gethostname()
      .. '.pkgs.php81Packages.'
      .. vim.fn.expand('<cword>')
      .. '.meta.homepage | xargs xdg-open'
    )
  end, 'php81Packages' },
  P = { function()
    vim.cmd(
      [[!nix eval nixos\#nixosConfigurations.]]
      .. vim.uv.os_gethostname()
      .. '.pkgs.php81Extensions.'
      .. vim.fn.expand('<cword>')
      .. '.meta.homepage | xargs xdg-open'
    )
  end, 'php81Extensions' },
}, { prefix = '<leader>g' })
