local sqls = require('lspconfig.server_configurations.svelte')
require('lspconfig').svelte.setup({})


vim.api.nvim_create_autocmd({ 'BufWritePre' },
  {
    group = 'Format',
    desc = 'svelte',
    pattern = { '*.svelte' },
    callback = function() vim.lsp.buf.format() end,
  })
