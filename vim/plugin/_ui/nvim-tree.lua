-- https://github.com/antosha417/nvim-lsp-file-operations
-- ~/.cache/nvim/nvim-lsp-file-operations
-- require('lsp-file-operations').setup({ debug = false })

-- https://github.com/kyazdani42/nvim-tree.lua
require('nvim-tree').setup({
  on_attach = function(bufnr)
    require('nvim-tree.api').config.mappings.default_on_attach(bufnr)
    vim.keymap.set(
      'n',
      '<C-Space>',
      tree_actions_menu,
      { buffer = bufnr, noremap = true, silent = true }
    )
  end,
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true, -- default false
    update_root = true, -- default false
    debounce_delay = 15,
    ignore_list = {},
  },
  git = { enable = false },
  view = { width = 25, signcolumn = 'no' },
})
