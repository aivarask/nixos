wkr({
  name = 'SessionManager',
  s = { '<cmd>:SessionManager load_session<cr>', 'load_session' },
  d = { '<cmd>:SessionManager delete_session<cr>', 'delete_session' },
  l = { '<cmd>:SessionManager load_last_session<cr>', 'load_last_session' },
  w = { '<cmd>:SessionManager save_current_session<cr>', 'save_current_session' },
  ['.'] = { '<cmd>:SessionManager load_current_dir_session<cr>', 'load_current_dir_session' },
  p = { require('telescope').extensions.projects.projects, 'projects' },
}, { prefix = '<leader>s' })

local Path = require('plenary.path')
-- https://github.com/Shatur/neovim-session-manager
require('session_manager').setup({
  sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'),
  path_replacer = '__',
  colon_replacer = '++',
  autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir,
  autosave_last_session = true,
  autosave_ignore_not_normal = true,
  autosave_ignore_dirs = {},
  autosave_ignore_filetypes = { 'gitcommit', 'gitrebase' },
  autosave_ignore_buftypes = { 'terminal' },
  autosave_only_in_session = false,
  max_path_length = 80,
})

-- https://github.com/ahmedkhalf/project.nvim
require('project_nvim').setup({
  -- Manual mode doesn't automatically change your root directory, so you have
  -- the option to manually do so using `:ProjectRoot` command.
  manual_mode = false,

  -- Methods of detecting the root directory. **"lsp"** uses the native neovim
  -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
  -- order matters: if one is not detected, the other is used as fallback. You
  -- can also delete or rearangne the detection methods.
  -- https://github.com/ahmedkhalf/project.nvim#pattern-matching
  detection_methods = {
    --
    -- 'lsp',
    'pattern',
  },

  -- All the patterns used to detect root dir, when **"pattern"** is in
  -- detection_methods
  patterns = {
    --
    'package.json',
    '.luarc.json',
  },

  -- Table of lsp clients to ignore by name
  -- eg: { "efm", ... }
  ignore_lsp = {},

  -- Don't calculate root dir on specific directories
  -- Ex: { "~/.cargo/*", ... }
  exclude_dirs = { '~', '*/node_modules/*' },

  -- Show hidden files in telescope
  show_hidden = false,

  -- When set to false, you will get a message when project.nvim changes your
  -- directory.
  silent_chdir = false,

  -- What scope to change the directory, valid options are
  -- * global (default)
  -- * tab
  -- * win
  scope_chdir = 'global',

  -- Path where project.nvim will store the project history for use in
  -- telescope
  datapath = vim.fn.stdpath('data'),
})

require('telescope').load_extension('projects')
