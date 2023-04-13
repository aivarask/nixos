-- https://github.com/rmagatti/auto-session/
vim.o.sessionoptions = 'blank,buffers,curdir,folds,tabpages,winsize,winpos,terminal,localoptions'
require('auto-session').setup({
  log_level = 'error',
  auto_save_enabled = true,
  auto_restore_enabled = true,
  pre_save_cmds = {
    'NvimTreeClose',
    'TroubleClose',
    ':lua require("neotest").output_panel.close()',
    ':lua require("neotest").summary.close()',
  },
  auto_session_allowed_dirs = {
    '/etc/nixos',
    '/etc/nixos/packages/*',
    '/etc/nixos/vim',
    '~/packages',
    '~/gh/*',
    '~/lk/*',
    '~/fixpart',
  },
})

-- https://github.com/rmagatti/session-lens#configuration
-- require('session-lens').setup({})
