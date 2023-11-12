vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Format before write',
  group = vim.api.nvim_create_augroup('format', { clear = true }),
  callback = function(opts)
    local buf_filetype = vim.bo[opts.buf].filetype
    local t = {
      -- ISSUE: vim.lsp.buf.format() opens all folds.
      typescript = 'tsserver',
      javascript = 'tsserver',
      prisma = 'prismals', -- Fold not found
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
          filter = function(client)
            return client.name == client_name
          end,
        })
        return
      end
    end
    vim.lsp.buf.format({
      filter = function(client)
        return client.name == 'null-ls'
      end,
    })
  end,
})
