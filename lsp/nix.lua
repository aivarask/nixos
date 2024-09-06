require "lspconfig".nil_ls.setup {
  autostart = true,
  settings = {
    ["nil"] = {
      formatting = { command = { "nixpkgs-fmt", }, },
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
  pattern = { "*.nix", },
  callback = function() vim.lsp.buf.format() end,
})
