require('help')

vim.lsp.config('*', {
  root_markers = { '.git' },
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      }
    }
  }
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method('textDocument/implementation') then
      -- Create a keymap for vim.lsp.buf.implementation ...
    end

    if client:supports_method('textDocument/codeLens') then
    end
    -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, {
        autotrigger = true,
        convert = function(item)
          return { abbr = item.label:gsub('%b()', '') }
        end,
      })
    end

    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end

    if client:supports_method('textDocument/signatureHelp') then
    end
  end,
})

-- vim.lsp.inlay_hint.enable()
vim.lsp.config.jsonls = {
  name = 'jsonls',
  cmd = { 'vscode-json-language-server', '--stdio' },
  root_markers = { 'packages.json' },
  filetypes = { 'json', 'jsonc' },
  settings = {
    json = {
      validate = { enable = true },
      format = { enable = true },
      schemas = require('schemastore').json.schemas({
        select = {
          '.eslintrc',
          'prettierrc.json',
          'package.json',
          'jsconfig.json',
          'tsconfig.json',
          'composer.json',
        },
        extra = {
          {
            fileMatch = { '*/snippets/*.json', '!*/snippets/package.json' },
            name = 'snippets',
            url = 'https://raw.githubusercontent.com/Yash-Singh1/vscode-snippets-json-schema/main/schema.json',
          },
        },
      }),
    },
  },
}

vim.lsp.enable({
  'luals',
  -- --
  'jsonls',
  'clangd',
  'nixd'
}, true)
vim.diagnostic.config({
  virtual_lines = true,
  virtual_text = true
})
