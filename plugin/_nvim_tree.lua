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
    enable = true,      -- default false
    update_root = true, -- default false
    debounce_delay = 15,
    ignore_list = {},
  },
  git = { enable = false },
  view = { width = 25, signcolumn = 'no' },
  ui = { confirm = { trash = false } },
})

-- https://github.com/nvim-tree/nvim-tree.lua/wiki
-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#h-j-k-l-style-navigation-and-editing
local api = require('nvim-tree.api')

local function edit_or_open()
  local node = api.tree.get_node_under_cursor()

  if node.nodes ~= nil then
    -- expand or collapse folder
    api.node.open.edit()
  else
    -- open file
    api.node.open.edit()
    -- Close the tree if file was opened
    api.tree.close()
  end
end

-- open as vsplit on current node
local function vsplit_preview()
  local node = api.tree.get_node_under_cursor()

  if node.nodes ~= nil then
    -- expand or collapse folder
    api.node.open.edit()
  else
    -- open file as vsplit
    api.node.open.vertical()
  end

  -- Finally refocus on tree if it was lost
  api.tree.focus()
end
