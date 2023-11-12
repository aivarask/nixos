-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#nil_ls
-- https://github.com/oxalica/nil/blob/main/docs/configuration.md
require('lspconfig').nil_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    ['nil'] = {
      testSetting = 42,
      formatting = {
        command = { 'alejandra' }, -- https://github.com/kamadorueda/alejandra
        -- command = { 'nixpkgs-fmt' }, -- https://github.com/nix-community/nixpkgs-fmt
        -- command = { 'nixfmt' }, -- https://github.com/serokell/nixfmt
      },
      maxMemoryMB = nil,
      flake = {
        --
        autoArchive = true,
        autoEvalInputs = true,
        -- TODO:
        -- ../modules/services/misc/nix-daemon.nix
        -- nixpkgsInputName = 'nixos',
        nixpkgsInputName = 'home-manager',
      },
    },
  },
})


