require('lspconfig').yamlls.setup({
  settings = {
    yaml = {
      format = { enable = true }
    }
  }
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*.yaml', '*.yml' },
  callback = function()
    vim.lsp.buf.format({
      async = true,
      filter = function(client)
        return client.name == 'yamlls'
      end,
    })
  end,
})
