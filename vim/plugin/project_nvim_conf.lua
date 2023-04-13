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
