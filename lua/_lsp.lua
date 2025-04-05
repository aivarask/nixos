vim.o.pumheight = 10

vim.cmd [[set completeopt+=menuone,noselect,popup]]
-- vim.o.completeopt = "menu,menuone,nosort,preview"
-- vim.o.completeopt = "fuzzy,menu,menuone,noselect,preview"



-- vim.lsp.config('*', {
-- root_markers = { '.git' },
-- capabilities = {
--   textDocument = {
--     semanticTokens = {
--       multilineTokenSupport = true,
--     }
--   }
-- }
-- })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method('textDocument/implementation') then
      -- Create a keymap for vim.lsp.buf.implementation ...
    end

    if client:supports_method('textDocument/codeLens') then
    end

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
    else
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = args.buf,
        callback = function()
          local ft = vim.fn.getbufvar(args.buf, '&filetype')
          if ft == 'json' or ft == 'jsonc' then
            vim.lsp.buf.format({ name = 'jsonls' })
          elseif ft == 'markdown' then
            vim.lsp.buf.format({ name = 'marksman' })
          end
        end,
      })
    end

    if client:supports_method('textDocument/signatureHelp') then
    end
  end,
})




vim.lsp.inlay_hint.enable(false)
vim.lsp.enable({
  'bashls',
  'clangd',
  'gopls',
  'htmx-lsp',
  'jsonls',
  'luals',
  'marksman',
  'nixd',
  'phpls',
  'pyright',
  'rustls',
  'sql',
  'stylelint',
  'templls',
  'tomlls',
  'typescript-language-server',
  'twigls',
  'vscode-css',
  'vscode-html',
  'yamlls',
  'zigls'
}, true)

vim.diagnostic.config({
  virtual_lines = true,
  virtual_text = true
})
