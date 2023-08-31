local unstable = 'https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/'
local hm = 'https://github.com/nix-community/home-manager/blob/master/'

wkr({
  name = 'Nix',
  h = {
    function()
      vim.cmd([[!xdg-open ]] .. hm .. vim.fn.expand('%'):gsub('home', 'modules'))
    end,
    '!xdg-open @nixos-unstable/%',
  },
  f = {
    function()
      vim.cmd([[!xdg-open ]] .. unstable .. vim.fn.expand('%'))
    end,
    '!xdg-open @nixos-unstable/%',
  },
}, { prefix = '<leader>N' })
