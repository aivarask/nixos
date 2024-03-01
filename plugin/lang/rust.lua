local ftmap = require('null-ls.builtins._meta.filetype_map').rust
local rust = {
  formatting = { "dprint", "leptosfmt", "rustfmt" },
}
require('null-ls').register({ require('null-ls.builtins.formatting.rustfmt') })

local rust_analyzer = require('lspconfig.server_configurations.rust_analyzer')
require('lspconfig').rust_analyzer.setup({})

vim.api.nvim_create_autocmd({ 'BufWritePre' },
  {
    group = 'Format',
    desc = 'rustfmt',
    pattern = { '*.rs' },
    callback = function() vim.lsp.buf.format() end,
  })
