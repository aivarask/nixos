local ftmap = require('null-ls.builtins._meta.filetype_map').prisma
local prisma = {
  formatting = { "prismaFmt" },
}
require('null-ls').register({
  require('null-ls.builtins.formatting.prismaFmt'),
})
-- prisma @prisma/language-server
local prismals = require('lspconfig.server_configurations.prismals')
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = 'Format',
  desc = 'prisma format ${filename}',
  pattern = { '*.prisma' },
  callback = function() vim.lsp.buf.format() end,
})
