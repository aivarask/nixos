-- local null_ls = require('null-ls')
-- null_ls.register({
-- null_ls.builtins.formatting.alejandra,
-- -- null_ls.builtins.formatting.nixfmt,
-- -- null_ls.builtins.formatting.nixpkgs_fmt,
-- null_ls.builtins.code_actions.statix,
-- null_ls.builtins.diagnostics.statix,
-- null_ls.builtins.diagnostics.deadnix.with({
--   args = { '--no-lambda-arg' },
-- }),
-- })

require('lspconfig').nil_ls.setup({
  settings = {
    ['nil'] = {
      formatting = {
        command = { 'nixpkgs-fmt' },
      },
    },
  },
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*.nix' },
  callback = function()
    print('pre')
    vim.lsp.buf.format({
      async = true,
      filter = function(client)
        return client.name == 'nil_ls'
      end,
    })
  end,
})
