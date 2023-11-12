wkr({
  ['<M-Tab>'] = { [[<cmd>tabnext<cr>]], 'tabnext', mode = { 'n', 'i', 't' } },
  ['<M-Del>'] = { [[<cmd>tabclose<cr>]], 'tabclose', mode = { 'n', 'i', 't' } },
  ['<C-b>'] = { cmp_complete_luasnip, 'cmp.complete.luasnip', mode = 'i' },
  K = { vim.lsp.buf.hover, 'vim.lsp.buf.hover' },
  qq = { require('nvim-tree.api').tree.toggle, 'nvim-tree.toggle' },
  QQ = { [[:SymbolsOutline<CR>]], 'SymbolsOutline' },
})

wkr({
  name = 'g',
  D = { vim.lsp.buf.declaration, 'vim.lsp.buf.declaration' },
  d = { vim.lsp.buf.definition, 'vim.lsp.buf.definition' },
  i = { vim.lsp.buf.implementation, 'vim.lsp.buf.implementation' },
  r = { vim.lsp.buf.references, 'vim.lsp.buf.references' },
  t = { vim.lsp.buf.type_definition, 'vim.lsp.buf.type_definition' },
  x = { [[\gx]], '!xdg-open <cfile>', noremap = false },
  q = {
    -- TODO: focus <cfile> in nvim-tree
    function()
      require('nvim-tree.api').tree.find_file({ 'modules/services/x11/redshift.nix', true })
    end,
    'nvim-tree.api.tree.find_file',
  },
}, { prefix = 'g' })
