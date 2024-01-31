require('lspconfig').nil_ls.setup({
  autostart = false,
  -- log_level = vim.lsp.log_levels.INFO,
  settings = {
    ['nil'] = {
      formatting = {
        command = { 'nixpkgs-fmt' },
      },
    },
  },
})

-- https://github.com/nix-community/nixd/blob/main/nixd/docs/nixd-schema.json
require('lspconfig').nixd.setup({
  autostart = true,
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*.nix' },
  callback = function()
    vim.lsp.buf.format({ async = true })
  end,
})
