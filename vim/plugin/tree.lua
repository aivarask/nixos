local function my_on_attach(bufnr)
  local api = require('nvim-tree.api')
  api.config.mappings.default_on_attach(bufnr)
end

-- https://github.com/kyazdani42/nvim-tree.lua
require('nvim-tree').setup({
  on_attach = my_on_attach,
  sync_root_with_cwd = true,
  root_dirs = {
    '/etc/nixos',
    '/etc/nixos/vim',
    '/root/fixpart',
  },
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
    lualine_z = {
      'searchcount',
    },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { vim.loop.cwd },
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = {
      function()
        return vim.api.nvim_buf_line_count(0)
      end,
      'location',
    },
  },
  inactive_sections = {
    lualine_c = { 'filename' },
    lualine_x = {
      'location',
      function()
        return vim.api.nvim_buf_line_count(0)
      end,
    },
  },
  extensions = { 'quickfix', 'nvim-tree', 'fzf', 'symbols-outline', 'toggleterm', 'man', 'trouble' },
})
