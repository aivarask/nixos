return {
  cmd = { 'nixd' },
  root_markers = { 'flake.lock' },
  -- root_dir = vim.fs.root(ev.buf, { 'flake.lock' }),
  filetypes = { 'nix' },
  settings = {
    nixd = {
      formatting = { command = { 'nixfmt' } },
      nixpkgs = { expr = 'import (builtins.getFlake "self").inputs.nixpkgs {}' },
      options = {
        nixos = { expr = '(builtins.getFlake "self").nixosConfigurations.dell.options' },
        -- home_manager = { expr = '(builtins.getFlake "self").nixosConfigurations.dell.options.home-manager.users.type.getSubOptions []', },
      },
      diagnostic = {
        suppress = {
          'sema-extra-with',
          'sema-unused-def-let',
          'sema-unused-def-lambda-noarg-formal'
        },
      },
    },
  },
}
