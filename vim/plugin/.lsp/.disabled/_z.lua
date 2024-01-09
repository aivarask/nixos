wkr({
  ['<C-b>'] = { cmp_complete_luasnip, 'cmp.complete.luasnip', mode = 'i' },
  K = { vim.lsp.buf.hover, 'vim.lsp.buf.hover' },
})

wkr({
  name = 'g',
  D = { vim.lsp.buf.declaration, 'vim.lsp.buf.declaration' },
  d = { vim.lsp.buf.definition, 'vim.lsp.buf.definition' },
  i = { vim.lsp.buf.implementation, 'vim.lsp.buf.implementation' },
  r = { vim.lsp.buf.references, 'vim.lsp.buf.references' },
  t = { vim.lsp.buf.type_definition, 'vim.lsp.buf.type_definition' },
  x = { [[\gx]], '!xdg-open <cfile>', noremap = false },
}, { prefix = 'g' })
