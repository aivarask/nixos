local null_ls = require('null-ls')

null_ls.setup({
-- filetypes = { "markdown", "text", "jsonc" },
--   sources = {
--     null_ls.builtins.code_actions.refactoring
--   },
--   diagnostics_format = 'NLS (#{s}) [#{c}] #{m}',
})

local ft_map = require('null-ls.builtins._meta.filetype_map')
