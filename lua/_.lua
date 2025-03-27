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
vim.lsp.enable({ 'luals', 'clangd' })

require('null-ls').register({
  require('null-ls.builtins.formatting.clang_format'),
})

vim.diagnostic.config({
  virtual_lines = true,
  virtual_text = true
})



require('which-key').add({
  { '<C-N>', vim.lsp.completion.trigger, mode = 'i' }
})
