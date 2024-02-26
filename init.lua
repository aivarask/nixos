vim.cmd([[
  " let &runtimepath.=',/etc/nixos' " already in nix config
  source /etc/nixos/vimrc.vim
]])

vim.loader.enable()

vim.api.nvim_create_augroup('Format', { clear = true })
