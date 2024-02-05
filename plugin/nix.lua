require('lspconfig').nil_ls.setup({
  autostart = true,
  -- log_level = vim.lsp.log_levels.INFO,
  -- https://github.com/oxalica/nil/blob/main/docs/configuration.md#lsp-configuration
  settings = {
    ['nil'] = {
      formatting = {
        command = { 'nixpkgs-fmt' },
      },
      -- nix = {
      --   maxMemoryMB = 5120,
      --   flake = {
      --     autoArchive = true,
      --     autoEvalInputs = true,
      --     nixpkgsInputName = "nixos",
      --   },
      -- },
    },
  },
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*.nix' },
  callback = function()
    vim.lsp.buf.format({ async = true })
  end,
})
