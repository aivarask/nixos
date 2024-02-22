local ftmap = require('null-ls.builtins._meta.filetype_map').c
local c = {
  diagnostics = { "clang_check", "cppcheck", "cpplint", "gccdiag" },
  formatting = { "astyle", "clang_format", "uncrustify" },
}

local ccls = require('lspconfig.server_configurations.ccls')
require('lspconfig').ccls.setup { autostart = false, root_dir = require('lspconfig.util').root_pattern('Makefile') }

local clangd = require('lspconfig.server_configurations.clangd')
require('lspconfig').clangd.setup({ autostart = true, root_dir = require('lspconfig.util').root_pattern('Makefile') })

vim.api.nvim_create_autocmd({ 'BufWritePre' },
  { group = 'Format', desc = 'clangd', pattern = { '*.c', '*.h' }, callback = vim.lsp.buf.format })
