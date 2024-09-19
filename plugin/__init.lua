vim.loader.enable()
vim.cmd([[
" let &runtimepath.=',/etc/nixos/pack/osv'
" runtime! key/**/*{.lua,.vim}
]])

vim.o.sessionoptions = 'buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
require('telescope').load_extension('session-lens')
require('auto-session').setup({ --- @see AutoSession
  log_level = vim.log.levels.INFO,
  auto_session_allowed_dirs = { '/etc/nixos' },
})

require('notif')
require('dapl')
require('ls')
require('completion')
require('completion_p')
