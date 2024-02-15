-- See https://github.com/bmewburn/intelephense-docs
-- phan phpactor psalm
require('lspconfig').intelephense.setup({
  root_dir = require('lspconfig.util').root_pattern('composer.json', '.git', 'index.php'),
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*.php' },
  callback = function() vim.lsp.buf.format({ filter = function(client) return client.name == 'intelephense' end }) end,
})

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
