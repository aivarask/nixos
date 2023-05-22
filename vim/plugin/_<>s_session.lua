wkr({
  name = 'SessionManager',
  s = { '<cmd>:SessionManager load_session<cr>', 'load_session' },
  d = { '<cmd>:SessionManager delete_session<cr>', 'delete_session' },
  l = { '<cmd>:SessionManager load_last_session<cr>', 'load_last_session' },
  w = { '<cmd>:SessionManager save_current_session<cr>', 'save_current_session' },
  ['.'] = { '<cmd>:SessionManager load_current_dir_session<cr>', 'load_current_dir_session' },
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
  autosave_ignore_filetypes = { 'gitcommit' },
  autosave_ignore_buftypes = { 'terminal' },
  autosave_only_in_session = false,
  max_path_length = 80,
})

local config_group = vim.api.nvim_create_augroup('MyConfigGroup', {})
vim.api.nvim_create_autocmd({ 'User' }, {
  pattern = { 'SessionLoadPost' },
  group = config_group,
  callback = function()
    -- tree.toggle(false, true)
    -- if vim.tbl_contains({ '/root/fixpart' }, function(v)
    --   return v == vim.loop.cwd()
    -- end) then
    --   print('success')
    --   neotest.summary.open()
    -- else
    --   print('not')
    -- end
    if vim.loop.cwd() == '/root/fixpart' then
      neotest.summary.open()
      neotest.summary:expand(vim.loop.cwd(), true)
    end
    -- pretty(neotest.summary)
  end,
})

vim.api.nvim_create_autocmd({ 'User' }, {
  pattern = 'SessionSavePost',
  group = config_group,
  callback = function()
    print('User autocmd')
  end,
})
