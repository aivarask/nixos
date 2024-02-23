-- See https://github.com/bmewburn/intelephense-docs
-- phan phpactor psalm
require('lspconfig').intelephense.setup({
  root_dir = require('lspconfig.util').root_pattern('composer.json', '.git', 'index.php'),
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = 'Format',
  desc = 'intelephense',
  pattern = { '*.php' },
  callback = function() vim.lsp.buf.format() end,
})
