-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#nil_ls
-- ../modules/services/misc/nix-daemon.nix
require('lspconfig').nil_ls.setup({
  -- https://github.com/oxalica/nil/blob/main/docs/configuration.md
  settings = {
    ['nil'] = {
      formatting = {
        command = { 'alejandra' }, -- https://github.com/kamadorueda/alejandra
        -- command = { 'nixpkgs-fmt' }, -- https://github.com/nix-community/nixpkgs-fmt
        -- command = { 'nixfmt' }, -- https://github.com/serokell/nixfmt
        -- command = nil,
      },
      nix = {
        binary = 'nix',
        maxMemoryMB = 2560,
        -- maxMemoryMB = nil,
        flake = {
          --
          autoArchive = false,
          autoEvalInputs = false,
          -- nixpkgsInputName = 'nixos',
          nixpkgsInputName = 'nixpkgs',
          -- nixpkgsInputName = 'home-manager',
        },
      },
    },
  },
})
