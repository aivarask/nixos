local doc = vim.api.nvim_create_augroup('doc', {})
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  group = doc,
  pattern = { 'doc/*' },
  command = "helptags doc | echo 'helptags doc'",
})
