wk = require("which-key")
---@type wk.Opts
local wkconfig = {}
wk.setup({ preset = 'helix' })
vim.api.nvim_create_augroup('Format', { clear = true })
vim.cmd([[
  " let &runtimepath.=',/etc/nixos' " already in nix config
  let &runtimepath.=',/root/one-small-step-for-vimkind'
  runtime! tdd/**/*{.lua,.vim}
  runtime! dsl/**/*{.lua,.vim}
  source /etc/nixos/vimrc.vim
]])

vim.loader.enable()

vim.cmd([[
]])
