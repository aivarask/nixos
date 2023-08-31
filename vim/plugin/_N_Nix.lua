local unstable = 'https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/'

wkr({
  name = 'Nix',
  f = {
    function()
      vim.cmd([[!xdg-open ]] .. unstable .. vim.fn.expand('%'))
    end,
    '!xdg-open @nixos-unstable/%',
  },
}, { prefix = '<leader>N' })
