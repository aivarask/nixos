require('lspconfig').nil_ls.setup({
  settings = {
    ['nil'] = {
      formatting = {
        command = { 'nixpkgs-fmt' },
      },
    },
  },
})

-- require('lspconfig').nixd.setup({})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*.nix' },
  callback = function()
    print('pre')
    vim.lsp.buf.format({
      async = true,
      -- filter = function(client)
      --   return client.name == 'nixd'
      --   -- return client.name == 'nil_ls'
      -- end,
    })
  end,
})
