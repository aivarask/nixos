local null_ls = require('null-ls')
null_ls.register({
  null_ls.builtins.formatting.alejandra,
  -- null_ls.builtins.formatting.nixfmt,
  -- null_ls.builtins.formatting.nixpkgs_fmt,
  null_ls.builtins.code_actions.statix,
  null_ls.builtins.diagnostics.statix,
  null_ls.builtins.diagnostics.deadnix.with({
    args = { '--no-lambda-arg' },
  }),
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*.nix' },
  callback = function()
    vim.lsp.buf.format({
      async = true,
      filter = function(client)
        return client.name ~= 'null_ls'
      end,
    })
  end,
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#nil_ls
-- ../modules/services/misc/nix-daemon.nix
require('lspconfig').nil_ls.setup({
  -- https://github.com/oxalica/nil/blob/main/docs/configuration.md
  settings = {
    ['nil'] = {
      formatting = {
        command = { 'alejandra' }, -- https://github.com/kamadorueda/alejandra
        -- command = { 'nixpkgs-fmt' }, -- https://github.com/nix-community/nixpkgs-fmt
        -- command = { 'nixfmt' }, -- https://github.com/serokell/nixfmt
        -- command = nil,
      },
      nix = {

        binary = 'nix',
        maxMemoryMB = nil,
        flake = {
          --
          autoArchive = false,
          autoEvalInputs = false,
          -- nixpkgsInputName = 'nixos',
          nixpkgsInputName = 'nixpkgs',
          -- nixpkgsInputName = 'home-manager',
        },
      },
    },
  },
})
