vim.api.nvim_create_augroup('Format', { clear = true })
vim.cmd([[
  " let &runtimepath.=',/etc/nixos' " already in nix config
  let &runtimepath.=',/root/one-small-step-for-vimkind'
  source /etc/nixos/vimrc.vim
  runtime! dsl/**/*{.lua,.vim}
  runtime! dap/**/*{.lua,.vim}
]])

vim.loader.enable()


vim.cmd([[
]])
