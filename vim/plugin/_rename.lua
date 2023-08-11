wkr({
  name = 'Rename',
  n = { vim.lsp.buf.rename, 'vim.lsp.buf.rename' },
  w = {
    function()
      vim.lsp.buf.rename()
      vim.cmd('silent! wall')
    end,
    'vim.lsp.rename | write',
  },
}, { prefix = '<leader>r' })
