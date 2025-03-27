local library = {
  vim.env.VIMRUNTIME,
  '/etc/static/luajit/share/lua/5.1',
  '${3rd}/luv/library',
  -- '${3rd}/busted/library',
  -- '${3rd}/luassert/library',
}

local userThirdParty = {
  -- '/etc/static/lua-language-server/share/lua-language-server/meta/3rd',
}

local path = {
  'lua/?/init.lua',
  'lua/?.lua',
  --
  '?/init.lua',
  '?.lua',
}

local pathStrict = true

for i = #library, 1, -1 do
  local value = library[i]
  if string.find(value, 'myNeovimPackages') then
    table.remove(library, i)
  end
end
for _, name in ipairs({
  'plenary.nvim',
  'nvim%-nio',
  'nvim%-cmp',
  'outline.nvim',
  'nvim%-tree',
  'none%-ls.nvim',
  'nvim%-lspconfig',
  'toggleterm.nvim',
  'which%-key.nvim',
  'lsp%-file%-operations',
  'nvim%-dap',
  'nvim%-dap%-ui',
  'lualine.nvim',
  'telescope.nvim',
  'gitsigns.nvim',
}) do
  for _, path in ipairs(vim.api.nvim_list_runtime_paths()) do
    if string.find(path, name) then
      table.insert(library, path)
    end
  end
end

-- local client = vim.lsp.get_clients({ name = 'luals' })[1] or nil
-- if client ~= nil then
-- 	vim.print(client.settings.Lua.workspace.library)
-- 	client.settings.Lua.workspace.library = library
-- 	client.notify('workspace/didChangeConfiguration', { settings = client.settings })
-- end

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- -- capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
-- -- capabilities.workspace.fileOperations.didRename

-- require('null-ls').register({ require('null-ls.builtins.formatting.stylua') })
-- vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
-- 	pattern = { '*.lua' },
-- 	desc = 'format null-ls',
-- 	callback = function() vim.lsp.buf.format({ name = 'null-ls' }) end,
-- })

return {
  cmd = { 'lua-language-server' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.stylua.toml' },
  -- root_dir = vim.fs.root(0, { 'flake.lock' }),
  filetypes = { 'lua' },
  on_attach = function(client, bufnr)
    vim.lsp.completion.enable(true, client.id, bufnr, {
      autotrigger = true,
      convert = function(item)
        return { abbr = item.label:gsub('%b()', '') }
      end,
    })
  end,
  settings = {
    Lua = { --- @type LuaSettings
      completion = {
        autoRequire = true,
        callSnippet = 'Disable',
        displayContext = 7,
        enable = true,
        keywordSnippet = 'Both',
        postfix = '@',
      },
      diagnostics = { -- luals.github.io/wiki/diagnostics
        disable = { 'lowercase-global', 'unused-local', 'need-check-nil', 'empty-block' },
      },
      format = {
        enable = true
      },
      hint = {
        enable = true,
        arrayIndex = 'Auto',
        setType = true,
      },
      runtime = {
        version = 'LuaJIT',
        pathStrict = pathStrict,
        path = path,
      },
      workspace = {
        checkThirdParty = false, -- https://luals.github.io/wiki/settings/#workspacecheckthirdparty
        library = library,
        preloadFileSize = 600,
        ignoreDir = { 'node_modules', 'vendor' },
        -- https://luals.github.io/wiki/settings/#workspaceuserthirdparty
        userThirdParty = userThirdParty,
      },
    },
  }
}
