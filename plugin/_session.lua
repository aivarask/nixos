wkr({
  name = 'SessionManager',
  s = { '<cmd>:SessionManager load_session<cr>', 'load_session' },
  d = { '<cmd>:SessionManager delete_session<cr>', 'delete_session' },
  l = { '<cmd>:SessionManager load_last_session<cr>', 'load_last_session' },
  w = {
    '<cmd>:SessionManager save_current_session<cr>',
    'save_current_session',
  },
  ['.'] = {
    '<cmd>:SessionManager load_current_dir_session<cr>',
    'load_current_dir_session',
  },
}, { prefix = '<leader>s' })

local Path = require('plenary.path')
-- https://github.com/Shatur/neovim-session-manager
require('session_manager').setup({
  autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir,
  autosave_last_session = true,
  autosave_ignore_not_normal = true,
  autosave_ignore_dirs = { '/nix/store/**' },
  autosave_ignore_filetypes = { 'gitcommit', 'gitrebase' },
  autosave_ignore_buftypes = { 'terminal' },
  autosave_only_in_session = false,
  max_path_length = 80,
})
