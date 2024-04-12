require('null-ls').setup({
  -- filetypes = { "markdown", "text", "jsonc" },
  -- sources = { require('null-ls.builtins.code_actions.refactoring') },
  diagnostics_format = "#{m} [#{c}] (#{s}) null-ls",
})

local ftmap = require('null-ls.builtins._meta.filetype_map')
