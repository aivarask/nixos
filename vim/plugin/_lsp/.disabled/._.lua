root_pattern = require('lspconfig.util').root_pattern
flags = { debounce_text_changes = 150 }

-- capabilities = require('cmp_nvim_lsp').default_capabilities()

-- https://github.com/neovim/nvim-lspconfig/issues/725#issuecomment-1675633769
capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

-- https://github.com/neovim/nvim-lspconfig#suggested-configuration
on_attach = function(client, bufnr)
  -- https://github.com/Issafalcon/lsp-overloads.nvim#configuration
  -- if client.server_capabilities.signatureHelpProvider then
  --   require('lsp-overloads').setup(client, {
  --     keymaps = {
  --       next_signature = '<M-j>',
  --       previous_signature = '<M-k>',
  --       next_parameter = '<M-l>',
  --       previous_parameter = '<M-h>',
  --       close_signature = '<M-s>',
  --     },
  --   })
  -- end

  -- https://github.com/neovim/nvim-lspconfig/issues/725#issuecomment-1539822348
  vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('inform', { clear = false }),
    pattern = { '*.js', '*.ts' },
    callback = function(ctx)
      if client.name == 'svelte' then
        client.notify('$/onDidChangeTsOrJsFile', { uri = ctx.file })
      end
    end,
  })



  -- https://github.com/ray-x/lsp_signature.nvim
  local lsp_signature = require('lsp_signature')
  lsp_signature.on_attach({
    hint_enable = false,
    hint_prefix = '🚀 ',
    floating_window = false,
    -- floating_window_off_y = -1,
    -- floating_window_above_cur_line = false,
    close_timeout = 1000,
  }, bufnr)
end
