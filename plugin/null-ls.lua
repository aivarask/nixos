require('null-ls').setup({
  -- filetypes = { "markdown", "text", "jsonc" },
  -- sources = { require('null-ls.builtins.code_actions.refactoring') },
  diagnostics_format = 'NLS (#{s}) [#{c}] #{m}',
})

local ftmap = require('null-ls.builtins._meta.filetype_map')
