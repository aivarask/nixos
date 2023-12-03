-- https://github.com/neovim/nvim-lspconfig#suggested-configuration

wkr({
  ['[d'] = { vim.diagnostic.goto_prev, 'vim.diagnostic.goto_prev' },
  [']d'] = { vim.diagnostic.goto_next, 'vim.diagnostic.goto_next' },
})

wkr({
  e = { vim.diagnostic.open_float, 'vim.diagnostic.open_float' },
  q = { vim.diagnostic.setloclist, 'vim.diagnostic.setloclist' },
}, { prefix = '<space>' })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local buffer = ev.buf

    -- require('pl.pretty')(ev)

    -- vim.api.nvim_create_autocmd('BufWritePost', {
    --   group = vim.api.nvim_create_augroup('inform', { clear = false }),
    --   pattern = { '*.js', '*.ts' },
    --   callback = function(ctx)
    --     if client.name == 'svelte' then
    --       client.notify('$/onDidChangeTsOrJsFile', { uri = ctx.file })
    --     end
    --   end,
    -- })

    wkr({
      a = {
        vim.lsp.buf.code_action,
        'vim.lsp.buf.code_action',
        mode = { 'n', 'v' },
      },
    }, { prefix = '<leader>', buffer = buffer })

    wkr({
      gD = { vim.lsp.buf.declaration, 'vim.lsp.buf.declaration' },
      gd = { vim.lsp.buf.definition, 'vim.lsp.buf.definition' },
      K = { vim.lsp.buf.hover, 'vim.lsp.buf.hover' },
      gi = { vim.lsp.buf.implementation, 'vim.lsp.buf.implementation' },
      ['<F2>'] = {
        vim.lsp.buf.signature_help,
        'vim.lsp.signature_help',
        mode = { 'n', 'i' },
      },
      ['<F3>'] = {
        require('lsp_signature').toggle_float_win,
        'lsp_signature.toggle_float_win',
        mode = { 'n', 'i' },
      },
      gr = { vim.lsp.buf.references, 'vim.lsp.buf.references' },
    }, { buffer = buffer })

    wkr({
      D = { vim.lsp.buf.type_definition, 'vim.lsp.type_definition' },
      rn = { vim.lsp.buf.rename, 'vim.lsp.buf.rename' },
      f = {
        function()
          vim.lsp.buf.format({
            async = true,
            filter = function(client) return client.name ~= 'null-ls' end,
          })
        end,
        'vim.lsp.buf.format ~= null-ls',
      },
      F = {
        function()
          vim.lsp.buf.format({
            async = true,
            filter = function(client)
              print('Format using = null-ls ')
              return client.name == 'null-ls'
            end,
          })
        end,
        'vim.lsp.buf.format NULL-LS',
      },
    }, { prefix = '<space>', buffer = buffer })

    wkr({
      name = 'Workspace',
      a = {
        vim.lsp.buf.add_workspace_folder,
        'vim.lsp.buf.add_workspace_folder',
      },
      r = {
        vim.lsp.buf.remove_workspace_folder,
        'vim.lsp.buf.remove_workspace_folder',
      },
      l = {
        function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
        'vim.lsp.list_workspace_folders',
      },
    }, { prefix = '<space>w', buffer = buffer })
  end,
})
