local ftmap = require "null-ls.builtins._meta.filetype_map".nix
local nix = {
  code_actions = { "statix", },
  diagnostics = { "deadnix", "statix", },
  formatting = { "alejandra", "nixfmt", "nixpkgs_fmt", },
}

require "lspconfig".nil_ls.setup {
  autostart = true,
  -- log_level = vim.lsp.log_levels.INFO,
  -- https://github.com/oxalica/nil/blob/main/docs/configuration.md#lsp-configuration
  settings = {
    ["nil"] = {
      formatting = {
        command = { "nixpkgs-fmt", },
      },
      nix = {
        maxMemoryMB = 20480,
        flake = {
          -- autoArchive = true,
          -- autoEvalInputs = true,
          nixpkgsInputName = "nixpkgs",
        },
      },
    },
  },
}

vim.api.nvim_create_autocmd({ "BufWritePre", }, {
  group = "Format",
  desc = "nil_ls > nixpkgs-fmt",
  pattern = { "*.nix", },
  callback = function() vim.lsp.buf.format() end,
})
