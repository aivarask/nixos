wkr({
  name = 'Rename',
  n = { vim.lsp.buf.rename, 'vim.lsp.buf.rename' },
  f = {
    function()
      -- vim.lsp.util.rename('foo.ts', 'fooz.ts')
    end,
    'vim.lsp.util.rename',
  },
}, { prefix = '<leader>r' })
