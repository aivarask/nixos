vim.api.nvim_create_augroup('Format', { clear = true })
vim.cmd([[
  " let &runtimepath.=',/etc/nixos' " already in nix config
  source /etc/nixos/vimrc.vim
  runtime! dsl/**/*{.lua,.vim}
]])

vim.loader.enable()


vim.cmd([[
]])
