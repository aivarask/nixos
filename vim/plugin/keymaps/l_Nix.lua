local nixos_unstable = 'https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/'
local home_manager = 'https://github.com/nix-community/home-manager/blob/master/'

wkr({
  name = 'Nix',
  a = {
    function()
      local path = vim.fn.expand('%')
    end,
    'xdg-open %',
  },
  h = {
    function()
      vim.cmd([[!xdg-open ]] .. home_manager .. vim.fn.expand('%'):gsub('home', 'modules'))
    end,
    '!xdg-open @home-manager/%',
  },
  f = {
    function()
      vim.cmd([[!xdg-open ]] .. nixos_unstable .. vim.fn.expand('%'))
    end,
    '!xdg-open @nixos-unstable/%',
  },
  t = {
    function()
      assert(false == true, 'Assert fails')
      print('some')
      local path = vim.fn.expand('%')
    end,
    '',
  },
}, { prefix = '<leader>N' })
