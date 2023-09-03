-- https://github.com/antosha417/nvim-lsp-file-operations
require('lsp-file-operations').setup()

wk = require('which-key')
wk.setup({})
wkr = require('which-key').register
tree = require('nvim-tree.api').tree
widgets = require('dap.ui.widgets')
osv = require('osv')

root_pattern = require('lspconfig.util').root_pattern
capabilities = require('cmp_nvim_lsp').default_capabilities()

-- https://github.com/neovim/nvim-lspconfig#suggested-configuration
on_attach = function(client, bufnr)
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

  -- local bufopts = { noremap = true, silent = true, buffer = bufnr }
end
flags = { debounce_text_changes = 150 }
