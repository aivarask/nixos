require('which-key').register({
  d = { function()
    vim.cmd(
      [[!nix eval nixos\#nixosConfigurations.]]
      .. vim.uv.os_gethostname()
      .. '.pkgs.'
      .. vim.fn.expand('<cword>')
      .. '.meta.description | xargs notify-send'
    )
  end, 'description' },
  D = { function()
    vim.cmd(
      [[!nix eval nixos\#nixosConfigurations.]]
      .. vim.uv.os_gethostname()
      .. '.pkgs.'
      .. vim.fn.expand('<cword>')
      .. [[.meta.longDescription --raw | xargs -0 notify-send]]
    )
  end, 'longDescription' },
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
