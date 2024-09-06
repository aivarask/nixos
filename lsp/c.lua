require "lspconfig".clangd.setup {
  autostart = true,
  root_dir = require "lspconfig.util".root_pattern "Makefile",
}

vim.api.nvim_create_autocmd({ "BufWritePre", }, {
  group = "Format",
  pattern = { "*.c", "*.h", },
  desc = "clangd",
  callback = function() vim.lsp.buf.format() end,
})
