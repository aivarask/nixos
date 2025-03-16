require('help')
require('lsp.all')
require('lsp.markup')
-- require('completion')

vim.lsp.config('*', {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      }
    }
  }
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    -- vim.bo[args.buf].formatexpr = nil
    -- vim.bo[args.buf].omnifunc = vim.lsp.omnifunc

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client:supports_method('textDocument/implementation') then
      -- Create a keymap for vim.lsp.buf.implementation
    end

    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end

    if client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
        end,
      })
    end
  end,
})
vim.lsp.enable('luals')
print(foo)

require('which-key').add({
  { '<C-N>', vim.lsp.completion.trigger, mode = 'i' }
})

vim.keymap.set('n', 'gK', function()
  local new_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = 'Toggle diagnostic virtual_lines' })
