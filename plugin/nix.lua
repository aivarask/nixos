require('lspconfig').nil_ls.setup({
  autostart = true,
  -- log_level = vim.lsp.log_levels.INFO,
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
    vim.lsp.buf.format({ async = true })
  end,
})
