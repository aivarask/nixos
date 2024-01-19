vim.filetype.add({
  extension = {
    templ = 'templ',
  },
})

require('lspconfig').templ.setup({})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*.templ' },
  callback = function()
    vim.lsp.buf.format({
      async = true,
      filter = function(client)
        return client.name == 'templ'
      end
    })
  end,
})

require('lspconfig').gopls.setup({})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*.go' },
  callback = function()
    vim.lsp.buf.format({
      async = true,
      filter = function(client)
        return client.name == 'gopls'
      end
    })
  end,
})
