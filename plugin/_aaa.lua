local wkr = require('which-key').register

wkr({
  qq = { require('nvim-tree.api').tree.toggle, 'nvim-tree.toggle' },
})

wkr({
  name = '1L',
  [']'] = { [[:SymbolsOutline<CR>]], 'SymbolsOutline' },
}, { prefix = '<leader>' })

wkr({
  name = 'Lsp,LazyGit,Lf',
  i = { [[:LspInfo<CR>]], 'LspInfo' },
  l = { [[:LspLog<CR>]], 'LspLog' },
  c = { LspLogClear, 'LspLogClear' },
  r = { [[:LspRestart<CR>]], 'LspRestart' },
  g = { [[:LazyGit<CR>]], 'LazyGit' },
  f = { [[:LfCurrentDirectory<CR>]], 'LfCurrentDirectory' },
  t = { [[:LfNewTab<CR>]], 'LfNewTab' },
  w = { [[:LfWorkingDirectory<CR>]], 'LfWorkingDirectory' },
}, { prefix = '<leader>l' })

wkr({
  name = 'Leader Leader',
}, { prefix = '<leader><leader>' })
