require('lspconfig').taplo.setup({})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*.toml' },
  callback = function()
    vim.lsp.buf.format({
      async = true,
      filter = function(client)
        return client.name == 'taplo'
      end,
    })
  end,
})
