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
