-- https://github.com/charmbracelet/glamour
-- https://github.com/charmbracelet/glow
-- https://github.com/ellisonleao/glow.nvim
require('glow').setup({
  border = 'shadow', -- floating window border config
  style = 'dark',
  pager = false,
  width = 80,
  height = 100,
  width_ratio = 0.9, -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
  height_ratio = 0.9,
})

-- https://github.com/kyazdani42/nvim-tree.lua
require('nvim-tree').setup({
  on_attach = require('nvim-tree.api').config.mappings.default_on_attach,
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true, -- default false
    update_root = true, -- default false
    debounce_delay = 15,
    ignore_list = {},
  },
  git = { enable = false },
})

-- https://github.com/antosha417/nvim-lsp-file-operations
-- ~/.cache/nvim/nvim-lsp-file-operations
require('lsp-file-operations').setup({ debug = false })

-- https://github.com/kdheepak/tabline.nvim#lualine-tabline-support
require('tabline').setup({ enable = false })
-- https://github.com/nvim-lualine/lualine.nvim
require('lualine').setup({
  options = {
    disabled_filetypes = {
      statusline = { 'NvimTree', 'neotest-summary', 'neotest-output-panel' },
      winbar = { 'NvimTree', 'neotest-summary', 'neotest-output-panel' },
      'dapui_watches',
      'dapui_breakpoints',
      'dapui_scopes',
      'dapui_console',
      'dapui_stacks',
      'dap-repl',
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
    lualine_b = { vim.uv.cwd },
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
