local ftmap = require('null-ls.builtins._meta.filetype_map').rust
local rust = {
  formatting = { "dprint", "leptosfmt", "rustfmt" },
}
require('null-ls').register({
  -- require('null-ls.builtins.formatting.rustfmt'),
})

local rust_analyzer = require('lspconfig.server_configurations.rust_analyzer')
require('lspconfig').rust_analyzer.setup({
  init_options = {
    ['rust-analyzer'] = {
      -- rust-analyzer.rustfmt.rangeFormatting.enable (default: false)
      -- rustFmt = {
        -- rangeFormatting = { enable = true },
      -- },
    },
  },
})

vim.api.nvim_create_autocmd({ 'BufWritePre' },
  {
    group = 'Format',
    desc = 'pyright',
    pattern = { '*.rs' },
    callback = function() vim.lsp.buf.format() end,
  })
