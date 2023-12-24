local null_ls = require('null-ls')
null_ls.register({
  sources = {
    -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md#zsh
    null_ls.builtins.diagnostics.zsh,
    -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md#beautysh
    -- null_ls.builtins.formatting.beautysh
  },
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*.zsh' },
  callback = function()
    vim.lsp.buf.format({ async = true })
  end,
})
