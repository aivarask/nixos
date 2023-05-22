wkr({
  name = 'Rename',
  n = { vim.lsp.buf.rename, 'vim.lsp.buf.rename' },
  w = {
    function()
      vim.lsp.buf.rename()
      vim.cmd('silent! wall')
    end,
    'vim.lsp.rename |  write',
  },
  f = {
    function()
      -- vim.lsp.util.rename('foo.ts', 'fooz.ts')
    end,
    'vim.lsp.util.rename',
  },
}, { prefix = '<leader>r' })
