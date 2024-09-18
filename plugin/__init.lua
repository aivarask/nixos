vim.loader.enable()
vim.cmd([[
let &runtimepath.=',/etc/nixos/pack/one-small-step-for-vimkind'
" runtime! key/**/*{.lua,.vim}
]])

vim.o.sessionoptions = 'buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
require('auto-session').setup({
  log_level = vim.log.levels.INFO,
  auto_session_allowed_dirs = { '/etc/nixos' },
})

require('notifications')
require('dapl.setup')
-- require 'dapl.ui'
-- require 'dapl.lua'
require('ls.lua')
require('completion')
require('completion_p')
