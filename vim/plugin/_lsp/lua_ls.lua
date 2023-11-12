-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
-- https://github.com/LuaLS/lua-language-server/wiki/Settings

local library = {
  vim.uv.cwd(),
  vim.env.VIMRUNTIME,
}

for _, value in pairs(vim.split(os.getenv('LUA_LIB') or '', ';')) do
  table.insert(library, value)
end

-- NOTE: % is escape char in Lua
local matchers = {
  -- DAP
  'nvim%-dap',
  -- LSP
  'nvim%-lspconfig',
  'SchemaStore%.nvim',
  'null%-ls.nvim',
  -- COMPLETION
  'nvim%-cmp',
  --   NEOTEST
  'neotest$',
  'neotest%-plenary$',
  'neotest%-vitest$',
  'neotest%-playwright$',
  -- UI
  'project.nvim',
  'session%-manager',
  'nvim%-tree',
  'dressing.nvim',
  -- KEYMAPS
  'which%-key%-nvim',
}

for _, path in ipairs(vim.api.nvim_get_runtime_file('', true)) do
  for _, name in ipairs(matchers) do
    if string.find(path, name) then
      table.insert(library, path)
    end
  end
end

local settings = {
  Lua = {
    runtime = {
      version = 'LuaJIT',
      path = {
        -- https://github.com/LuaLS/lua-language-server/wiki/Settings#runtimepath
        '?.lua',
        '?/init.lua',
        -- 'lua/?.lua',
        -- 'lua/?/init.lua',
        -- '?/?.lua',
      },
      pathStrict = false,
    },
    diagnostics = {
      globals = { 'vim', 'awesome' },
    },
    workspace = {
      library = library,
      checkThirdParty = false,
    },
    telemetry = {
      enable = false,
    },
    completion = {
      callSnippet = 'Replace',
      displayContext = 8,
    },
    format = {
      enable = true,
    },
  },
}

local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = settings,
  root_dir = root_pattern(
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git'
  ),
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings.Lua, settings)
      client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
    end
    return true
  end,
})
