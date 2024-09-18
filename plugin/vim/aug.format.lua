local format = vim.api.nvim_create_augroup('format', {})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = format,
  pattern = {
    '*.c',
    '*.h',
    '*.cpp',
    '*.css',
    '*.go',
    '*.templ',
    '*.md',
    '*.nix',
    '*.js',
    '*.ts',
    '*.php',
    '*.py',
    '*.rs',
    '*.sh',
    '*.bash',
    '*.zsh',
    '*.sql',
    -- "*.lua",
    -- "*.vim",
    '*.json',
    '*.jsonc',
    '*.yaml',
    '*.yml',
    '*.zig',
  },
  desc = 'vim.lsp.buf.format()',
  callback = function() vim.lsp.buf.format() end,
  -- callback = function() return vim.lsp.buf.format { async = true, } end,
  -- callback = vim.lsp.buf.format,
})

require('persistent-breakpoints').setup({
  save_dir = vim.fn.stdpath('data') .. '/nvim_checkpoints',
  -- when to load the breakpoints? "BufReadPost" is recommanded.
  load_breakpoints_event = 'BufReadPost',
  -- record the performance of different function. run :lua require('persistent-breakpoints.api').print_perf_data() to see the result.
  perf_record = false,
  -- perform callback when loading a persisted breakpoint
  --- @param opts DAPBreakpointOptions options used to create the breakpoint ({condition, logMessage, hitCondition})
  --- @param buf_id integer the buffer the breakpoint was set on
  --- @param line integer the line the breakpoint was set on
  on_load_breakpoint = nil,
})
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
-- Save breakpoints to file automatically.
keymap('n', '<M-e>b', "<cmd>lua require('persistent-breakpoints.api').toggle_breakpoint()<cr>", opts)
-- keymap("n", "<YourKey2>", "<cmd>lua require('persistent-breakpoints.api').set_conditional_breakpoint()<cr>", opts)
-- keymap("n", "<YourKey3>", "<cmd>lua require('persistent-breakpoints.api').clear_all_breakpoints()<cr>", opts)
-- keymap("n", "<YourKey4>", "<cmd>lua require('persistent-breakpoints.api').set_log_point()<cr>", opts)
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = format,
  pattern = {
    '*.html',
    '*.xml',
    '*.twig',
    '*.lua',
  },
  desc = 'vim.lsp.buf.format null-ls',
  callback = function()
    vim.lsp.buf.format({
      async = true,
      filter = function(client) return client.name == 'null-ls' end,
    })
  end,
})
