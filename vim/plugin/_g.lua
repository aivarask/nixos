wkr({
  gx = { [[\gx]], '!xdg-open <cfile>' },
}, { noremap = false })

wkr({
  name = 'G',
  D = { vim.lsp.buf.declaration, 'declaration' },
  d = { vim.lsp.buf.definition, 'definition' },
  i = { vim.lsp.buf.implementation, 'implementation' },
  t = { vim.lsp.buf.type_definition, 'type_definition' },
  r = { vim.lsp.buf.references, 'references' },
}, { prefix = 'g' })

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
