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
  desc = 'vim.lsp.buf.format',
  callback = function()
    vim.lsp.buf.format()
  end,
})

require('persistent-breakpoints').setup({
  save_dir = vim.fn.stdpath('data') .. '/breakpoints',
  load_breakpoints_event = 'BufReadPost',
  perf_record = false,
  on_load_breakpoint = nil,
})
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
      filter = function(client)
        return client.name == 'null-ls'
      end,
    })
  end,
})
