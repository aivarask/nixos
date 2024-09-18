local wk = require('which-key')
wk.add({
  -- <M-k> lsp_signature toggle_key
  -- <M-s> lsp-overloads close_signature
  -- <M-w> https//github.com/windwp/nvim-autopairs#fastwrap
  { '<M-1>', '<cmd>Telescope find_files default_text=Make\\ |\\ .mk<CR>', mode = { 'n', 'i' } },
  { '<M-e>d', '<cmd>edit /etc/nixos/doc/nixos.txt<CR>' },
  { '<M-e>v', '<cmd>edit /etc/nixos/home/programs/vim.nix<CR>' },
  { '<M-e>s', '<cmd>edit ' .. vim.env.SXHKDRC .. '<CR>' },
  { '<M-e>f', '<cmd>edit flake.nix<CR>' },
  { '<M-e>l', '<cmd>Telescope find_files cwd=lua<CR>' },
  { '<M-e>p', '<cmd>Telescope find_files cwd=plugin<CR>' },
  { '<M-e><M-e>', '<cmd>Telescope find_files<CR>' },
  { '<M-f>', '<cmd>Files<cr>' },
  { '<M-g>', '<cmd>Rg<cr>' },
})

wk.add({
  {
    '?a',
    function() wk.show({}) end,
    desc = 'all',
  },
  {
    '??',
    function() wk.show({ global = false }) end,
    desc = 'w/o global',
  },
  {
    '?i',
    function() wk.show({ mode = 'i' }) end,
    desc = 'i',
  },
  {
    '?n',
    function() wk.show({ mode = 'n' }) end,
    desc = 'n',
  },
  {
    '?v',
    function() wk.show({ mode = 'v' }) end,
    desc = 'v',
  },
  {
    '?c',
    function() wk.show({ mode = 'c' }) end,
    desc = 'c',
  },
  {
    '?z',
    function() wk.show({ keys = '/' }) end,
    desc = 'z',
  },
})
