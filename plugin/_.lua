wkr({
  ['<M-Tab>'] = { [[<cmd>tabnext<cr>]], 'tabnext', mode = { 'n', 'i', 't' } },
  ['<M-Del>'] = { [[<cmd>tabclose<cr>]], 'tabclose', mode = { 'n', 'i', 't' } },
  qq = { require('nvim-tree.api').tree.toggle, 'nvim-tree.toggle' },
})

wkr({
  name = '1L',
  [']'] = { [[:SymbolsOutline<CR>]], 'SymbolsOutline' },
}, { prefix = '<leader>' })

wkr({
  name = '2L',
  a = { [[:call _#save_and_exec()<CR>]], ':call _#save_and_exec()' },
}, { prefix = '<leader><leader>' })
