vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Format before write',
  group = vim.api.nvim_create_augroup('UserLspFormat', { clear = true }),
  callback = function(opts)
    print('will format')
    local buf_filetype = vim.bo[opts.buf].filetype
    local t = {
      -- ISSUE: vim.lsp.buf.format() opens all folds.
      typescript = 'tsserver',
      javascript = 'null-ls',
      prisma = 'prismals', -- Fold not found
      -- sql = 'sqlls',
      -- json = 'jsonls',
      -- jsonc = 'jsonls',
      -- BAD:
      -- svelte = 'svelte',
      -- nix = 'nil_ls',
      -- lua = 'lua_ls',
    }
    for filetype, client_name in pairs(t) do
      if buf_filetype == filetype then
        vim.lsp.buf.format({
          async = true,
          filter = function(client) return client.name == client_name end,
        })
        return
      end
    end
    vim.lsp.buf.format({
      async = true,
      filter = function(client) return client.name == 'null-ls' end,
    })
  end,
})
