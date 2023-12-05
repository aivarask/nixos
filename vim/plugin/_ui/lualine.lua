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
    lualine_b = { { 'buffers', show_filename_only = false } },
    lualine_c = {},
    lualine_x = {
      -- {
      --   'filename',
      --   file_status = true, -- Displays file status (readonly status, modified status)
      --   newfile_status = false, -- Display new file status (new file means no write after created)
      --   path = 1, -- 0: Just the filename
      --   -- 1: Relative path
      --   -- 2: Absolute path
      --   -- 3: Absolute path, with tilde as the home directory
      --   -- 4: Filename and parent dir, with tilde as the home directory

      --   shorting_target = 20, -- Shortens path to leave 40 spaces in the window
      --   -- for other components. (terrible name, any suggestions?)
      --   symbols = {
      --     modified = '[+]', -- Text to show when the file is modified.
      --     readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
      --     unnamed = '[No Name]', -- Text to show for unnamed buffers.
      --     newfile = '[New]', -- Text to show for newly created file before first write
      --   },
      -- },
    },
    lualine_y = {},
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
