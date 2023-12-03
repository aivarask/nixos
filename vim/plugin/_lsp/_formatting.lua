vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Format before write',
  group = vim.api.nvim_create_augroup('UserLspFormat', { clear = true }),
  callback = function(opts)
    print('will format')
    local formatter = 'null-ls'
    local buf_filetype = vim.bo[opts.buf].filetype
    local t = {
      typescript = 'tsserver',
      javascript = 'null-ls',
      prisma = 'prismals',
      sql = 'sqlls',
      json = 'jsonls',
      jsonc = 'jsonls',
      -- BAD:
      -- svelte = 'svelte',
      nix = 'nil_ls',
      -- lua = 'lua_ls',
    }
    for filetype, client_name in pairs(t) do
      if buf_filetype == filetype then formatter = client_name end
    end

    print('_formatting ', buf_filetype, formatter)
    vim.lsp.buf.format({
      async = true,
      filter = function(client) return client.name == formatter end,
    })
  end,
})
