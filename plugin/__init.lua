vim.loader.enable()

vim.o.sessionoptions = 'buffers,curdir,folds,help,tabpages,winsize,winpos,terminal'
require('auto-session').setup({ --- @see AutoSession
  log_level = vim.log.levels.ERROR,
  auto_session_allowed_dirs = { '/etc/nixos' },
})

require('notif')
require('dapl')
require('ls')
require('completion')
