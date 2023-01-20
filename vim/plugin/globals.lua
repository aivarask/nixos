-- capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require('cmp_nvim_lsp').default_capabilities()
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
--   properties = { 'documentation', 'detail', 'additionalTextEdits' },
-- }
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.codeLens = true

flags = { debounce_text_changes = 150 }

-- https://github.com/neovim/nvim-lspconfig#suggested-configuration
on_attach = function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '?', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
  vim.keymap.set({ 'n', 'v' }, ']f', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set({ 'n' }, '<leader>ai', [[:TypescriptAddMissingImports<CR>]])
  vim.keymap.set({ 'n' }, '<leader>oi', [[:TypescriptOrganizeImports<CR>]])
  vim.keymap.set({ 'n' }, '<leader>rf', [[:TypescriptRenameFile<CR>]])
  if client == 'tsserver' then
    print('tsserver')
  end
end
