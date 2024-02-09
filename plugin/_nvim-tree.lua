vim.api.nvim_set_keymap('n', 'qq', [[:NvimTreeOpen<CR>]], { noremap = true, silent = true })

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


function sveltekit_file()
  local api = require('nvim-tree.api')
  return vim.ui.select({ '+page.server.ts', '+page.svelte', '+server.ts' }, {
    prompt = 'New file',
    format_item = function(item) return item end,
  }, function(item)
    if item == nil then
      return
    else
      local node = api.tree.get_node_under_cursor()
      local path
      if node.fs_stat.type == 'directory' then
        if node then
          path = node.absolute_path .. '/' .. item
        else
          path = node.parent.absolute_path .. '/' .. item
        end
      else
        path = vim.fn.expand('%:h') .. '/' .. item
      end
      vim.cmd.edit(path)
    end
  end)
end

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

-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#creating-an-actions-menu-using-telescope
local tree_actions = {
  {
    name = 'Create node',
    handler = require('nvim-tree.api').fs.create,
  },
  {
    name = 'Remove node',
    handler = require('nvim-tree.api').fs.remove,
  },
  {
    name = 'Trash node',
    handler = require('nvim-tree.api').fs.trash,
  },
  {
    name = 'Rename node',
    handler = require('nvim-tree.api').fs.rename,
  },
  {
    name = 'Fully rename node',
    handler = require('nvim-tree.api').fs.rename_sub,
  },
  {
    name = 'Copy',
    handler = require('nvim-tree.api').fs.copy.node,
  },

}

function tree_actions_menu(node)
  local entry_maker = function(menu_item)
    return {
      value = menu_item,
      ordinal = menu_item.name,
      display = menu_item.name,
    }
  end

  local finder = require('telescope.finders').new_table({
    results = tree_actions,
    entry_maker = entry_maker,
  })

  local sorter = require('telescope.sorters').get_generic_fuzzy_sorter()

  local default_options = {
    finder = finder,
    sorter = sorter,
    attach_mappings = function(prompt_buffer_number)
      local actions = require('telescope.actions')

      -- On item select
      actions.select_default:replace(function()
        local state = require('telescope.actions.state')
        local selection = state.get_selected_entry()
        -- Closing the picker
        actions.close(prompt_buffer_number)
        -- Executing the callback
        selection.value.handler(node)
      end)

      -- The following actions are disabled in this example
      -- You may want to map them too depending on your needs though
      actions.add_selection:replace(function() end)
      actions.remove_selection:replace(function() end)
      actions.toggle_selection:replace(function() end)
      actions.select_all:replace(function() end)
      actions.drop_all:replace(function() end)
      actions.toggle_all:replace(function() end)

      return true
    end,
  }

  -- Opening the menu
  require('telescope.pickers')
      .new({ prompt_title = 'Tree menu' }, default_options)
      :find()
end
