local null_ls = require('null-ls')
null_ls.register({
  null_ls.builtins.formatting.taplo,
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*.toml' },
  callback = function()
    vim.lsp.buf.format({
      async = true,
      filter = function(client)
        return client.name ~= 'null_ls'
      end,
    })
  end,
})
