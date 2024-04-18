vim.api.nvim_create_augroup('Format', { clear = true })
vim.cmd([[
  " let &runtimepath.=',/etc/nixos' " already in nix config
  let &runtimepath.=',/root/one-small-step-for-vimkind'
  runtime! dap/**/*{.lua,.vim}
  runtime! dsl/**/*{.lua,.vim}
  source /etc/nixos/vimrc.vim
]])

vim.loader.enable()


vim.cmd([[
]])
