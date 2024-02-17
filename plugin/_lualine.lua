--- @ https://github.com/nvim-lualine/lualine.nvim
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
    -- https://github.com/nvim-lualine/lualine.nvim#buffers-component-options
    lualine_a = { 'tabs' },
    lualine_b = {
      {
        'buffers',
        show_filename_only = true,
        max_length = vim.o.columns * 4 / 5,
        mode = 4,
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
    lualine_x = {
      {
        'lsp_progress',
        display_components = {
          'lsp_client_name',
          {
            'percentage',
          },
        },
      },
      'encoding',
      'fileformat',
      'filetype',
    },
    lualine_y = { 'progress' },
    lualine_z = {
      'location',
      function()
        return vim.api.nvim_buf_line_count(0)
      end,
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
  extensions = {
    'quickfix',
    'nvim-tree',
    'fzf',
    'symbols-outline',
    'toggleterm',
    'man',
    'trouble',
  },
})
