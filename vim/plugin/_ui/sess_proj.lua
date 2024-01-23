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
  p = { require('telescope').extensions.projects.projects, 'projects' },
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

---@type ProjectOptions
local options = {
  -- https://github.com/ahmedkhalf/project.nvim#pattern-matching
  manual_mode = true,
  detection_methods = { 'pattern' },
  patterns = {
    --
    -- '_.nix',
    'flake.nix',
    -- '^lua',
    -- 'package.json',
    '.luarc.json',
    '>packages',
    '>proj',
    '>sb',
    '!>.cache',
    '!/nix/store',
  },
  ignore_lsp = { 'null-ls' },
  exclude_dirs = {
    -- '/root/*',
    '*/node_modules/*',
    '/nix/store/*',
    '/etc/nixos/vim/lua/*',
    --
  },
  scope_chdir = 'global',
}
-- https://github.com/ahmedkhalf/project.nvim
require('project_nvim').setup(options)
require('telescope').load_extension('projects')
