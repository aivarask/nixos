local null_ls = require('null-ls')
null_ls.register({
  -- null_ls.builtins.formatting.alejandra,
  --   -- null_ls.builtins.formatting.nixfmt,
  -- null_ls.builtins.formatting.nixpkgs_fmt,
  --   -- null_ls.builtins.code_actions.statix,
  --   -- null_ls.builtins.diagnostics.statix,
  --   -- null_ls.builtins.diagnostics.deadnix.with({
  --   --   args = { '--no-lambda-arg' },
  --   -- }),
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*.nix' },
  callback = function()
    vim.lsp.buf.format({
      async = true,
      filter = function(client)
        return client.name == 'nil_ls'
      end,
    })
  end,
})
-- null_ls.setup({
--   sources = {
--     null_ls.builtins.code_actions.gitsigns,
--   },
--   diagnostics_format = 'NLS (#{s}) [#{c}] #{m}',
-- })

-- local nixd = require('lspconfig.server_configurations.nixd').default_config
-- require('lspconfig').nixd.setup({})
-- local nil_ls = require('lspconfig.server_configurations.nil_ls').default_config
require('lspconfig').nil_ls.setup({
  settings = {
    ['nil'] = {
      formatting = {
        command = { 'nixpkgs-fmt' },
      },
    },
  },
})

local taplo = require('lspconfig.server_configurations.taplo').default_config
require('lspconfig').taplo.setup(taplo)
