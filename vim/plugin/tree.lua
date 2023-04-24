-- https://github.com/kyazdani42/nvim-tree.lua
require('nvim-tree').setup({
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true, -- default false
    debounce_delay = 15,
    update_root = true, -- default false
    ignore_list = {},
  },
  git = { enable = false },
})

-- https://github.com/kdheepak/tabline.nvim#lualine-tabline-support
require('tabline').setup({ enable = false })
-- https://github.com/nvim-lualine/lualine.nvim
require('lualine').setup({
  options = {
    disabled_filetypes = {
      statusline = { 'NvimTree', 'neotest-summary', 'neotest-output-panel' },
      winbar = { 'NvimTree', 'neotest-summary', 'neotest-output-panel' },
    },
  },
  tabline = {
    lualine_c = { require('tabline').tabline_buffers },
    lualine_x = { require('tabline').tabline_tabs },
    lualine_y = {
      {
        'lsp_progress',
        display_components = { 'lsp_client_name', {
          'percentage',
        } },
      },
    },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { vim.loop.cwd },
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
  },
  extensions = { 'quickfix', 'nvim-tree', 'fzf', 'symbols-outline', 'toggleterm', 'man', 'trouble' },
})
