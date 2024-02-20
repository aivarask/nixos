local ftmap = require('null-ls.builtins._meta.filetype_map').c
local c = {
  diagnostics = { "clang_check", "cppcheck", "cpplint", "gccdiag" },
  formatting = { "astyle", "clang_format", "uncrustify" },
}

local lspconfig = require 'lspconfig'

local ccls = require('lspconfig.server_configurations.ccls')
lspconfig.ccls.setup {
  autostart = true,
  -- root_dir = [[root_pattern('compile_commands.json', '.ccls', '.git')]],
  root_dir = require('lspconfig.util').root_pattern('Makefile.in'),
  init_options = {
    compilationDatabaseDirectory = "build",
    index = {
      threads = 0,
    },
    clang = {
      excludeArgs = { "-frounding-math" },
    },
  },
}

local clangd = require('lspconfig.server_configurations.clangd')

lspconfig.clangd.setup({
  autostart = false,
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*.c', '*.h' },
  callback = function()
    vim.lsp.buf.format({
    })
  end,
})
