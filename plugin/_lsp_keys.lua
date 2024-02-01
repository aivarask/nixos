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
