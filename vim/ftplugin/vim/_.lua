local null_ls = require('null-ls')
null_ls.register({
  sources = {
    null_ls.builtins.diagnostics.vint, -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md#vint
  },
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*.vim' },
  callback = function()
    vim.lsp.buf.format({
      async = true,
      filter = function(client)
        return client.name ~= 'vimls'
      end,
    })
  end,
})

-- plugin/vim.lua
