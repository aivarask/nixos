local api = require('nvim-tree.api')
vim.keymap.set('n', 'qs', function()
  api.tree.toggle({ path = '', find_file = false, update_root = true, focus = false })
end)
-- https://github.com/ahmedkhalf/project.nvim#%EF%B8%8F-configuration
require('project_nvim').setup({
  manual_mode = false,
  detection_methods = { 'lsp', 'pattern' },
  patterns = { 'vimrc.vim', 'stylua.toml', 'flake.nix', 'package.json' },
  ignore_lsp = { 'null-ls' },
  exclude_dirs = {},
  scope_chdir = 'global',
})
-- require('telescope').load_extension('projects')

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
  -- cwd_change_handling = {
  --   restore_upcoming_session = true, -- already the default, no need to specify like this, only here as an example
  --   pre_cwd_changed_hook = nil, -- already the default, no need to specify like this, only here as an example
  --   post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
  --     require('lualine').refresh() -- refresh lualine so the new session name is displayed in the status bar
  --   end,
  -- },
})
-- https://github.com/rmagatti/session-lens#configuration
require('session-lens').setup({})

-- INFO: async rename and create file LSP rename
-- https://github.com/nvim-tree/nvim-tree.lua/pull/1870
-- https://github.com/antosha417/nvim-lsp-file-operations
require('lsp-file-operations').setup()

-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Open-At-Startup#recipes
local function open_nvim_tree(data)
  local real_file = vim.fn.filereadable(data.file) == 1 -- buffer is a real file on the disk
  local no_name = data.file == '' and vim.bo[data.buf].buftype == '' -- buffer is a [No Name]
  if not real_file and not no_name then
    return
  end
  require('nvim-tree.api').tree.toggle({ focus = false, find_file = true })
end
vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = open_nvim_tree })
-- https://github.com/kyazdani42/nvim-tree.lua
-- https://github.com/ahmedkhalf/project.nvim#-features
require('nvim-tree').setup({
  auto_reload_on_write = true,
  disable_netrw = false,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  ignore_buffer_on_setup = false,
  -- open_on_setup = false,
  -- open_on_setup_file = false,
  sort_by = 'name',
  root_dirs = {},
  prefer_startup_root = false,
  sync_root_with_cwd = false, -- default false
  reload_on_bufenter = false,
  respect_buf_cwd = false,
  on_attach = 'disable',
  remove_keymaps = false,
  select_prompts = false,
  view = {
    adaptive_size = false,
    centralize_selection = false,
    width = 30,
    hide_root_folder = false,
    side = 'left',
    preserve_window_proportions = true,
    number = false,
    relativenumber = false,
    signcolumn = 'yes',
    mappings = {
      custom_only = false,
      list = {
        { key = 'u', action = 'dir_up' },
        -- { key = "cr", action = "change_up" },
      },
    },
    float = {
      enable = false,
      quit_on_focus_loss = true,
      open_win_config = {
        relative = 'editor',
        border = 'rounded',
        width = 30,
        height = 30,
        row = 1,
        col = 1,
      },
    },
  },
  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = false,
    full_name = false,
    highlight_opened_files = 'none',
    root_folder_label = ':~:s?$?/..?',
    indent_width = 2,
    indent_markers = {
      enable = false,
      inline_arrows = true,
      icons = {
        corner = '└',
        edge = '│',
        item = '│',
        bottom = '─',
        none = ' ',
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = 'after',
      padding = ' ',
      symlink_arrow = ' ➛ ',
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = '',
        symlink = '',
        bookmark = '',
        folder = {
          arrow_closed = '',
          arrow_open = '',
          default = '',
          open = '',
          empty = '',
          empty_open = '',
          symlink = '',
          symlink_open = '',
        },
        git = {
          unstaged = '✗',
          staged = '✓',
          unmerged = '',
          renamed = '➜',
          untracked = '★',
          deleted = '',
          ignored = '◌',
        },
      },
    },
    special_files = { 'Cargo.toml', 'Makefile', 'README.md', 'readme.md' },
    symlink_destination = true,
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = true, -- default false
    debounce_delay = 15,
    update_root = true, -- default false
    ignore_list = {},
  },
  ignore_ft_on_setup = {},
  system_open = {
    cmd = '',
    args = {},
  },
  diagnostics = {
    enable = true,
    show_on_dirs = false,
    show_on_open_dirs = true,
    debounce_delay = 50,
    severity = {
      min = vim.diagnostic.severity.HINT,
      max = vim.diagnostic.severity.ERROR,
    },
    icons = {
      hint = '',
      info = '',
      warning = '',
      error = '',
    },
  },
  filters = {
    dotfiles = false,
    git_clean = false,
    no_buffer = false,
    custom = {},
    exclude = {},
  },
  filesystem_watchers = {
    enable = true,
    debounce_delay = 50,
    ignore_dirs = {},
  },
  git = {
    enable = false,
    ignore = true,
    show_on_dirs = true,
    show_on_open_dirs = true,
    timeout = 400,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    expand_all = {
      max_folder_discovery = 300,
      exclude = {},
    },
    file_popup = {
      open_win_config = {
        col = 1,
        row = 1,
        relative = 'cursor',
        border = 'shadow',
        style = 'minimal',
      },
    },
    open_file = {
      quit_on_open = false,
      resize_window = true,
      window_picker = {
        enable = true,
        picker = 'default',
        chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
        exclude = {
          filetype = { 'notify', 'packer', 'qf', 'diff', 'fugitive', 'fugitiveblame' },
          buftype = { 'nofile', 'terminal', 'help' },
        },
      },
    },
    remove_file = {
      close_window = true,
    },
  },
  trash = {
    cmd = 'gio trash',
    require_confirm = true,
  },
  live_filter = {
    prefix = '[FILTER]: ',
    always_show_folders = true,
  },
  tab = {
    sync = {
      open = false,
      close = false,
      ignore = {},
    },
  },
  notify = {
    threshold = vim.log.levels.INFO,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      dev = false,
      diagnostics = false,
      git = false,
      profile = false,
      watcher = false,
    },
  },
})
