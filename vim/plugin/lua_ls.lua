-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
-- https://github.com/LuaLS/lua-language-server/wiki/Settings
local library = {
  vim.loop.cwd(),
}
local matchers = {
  'neodev%-nvim',
  'which%-key%-nvim',
  'auto%-session',
  'nvim%-cmp',
  'neotest$',
  'neotest%-plenary$',
  'neotest%-playwright$',
  'neotest%-vitest$',
  'nvim%-treesitter$',
  'project.nvim',
  'telescope.nvim',
  'todo%-comments.nvim',
  'trouble.nvim',
  'vimplugin%-nvim%-tree',
  'tabline.nvim',
  'lualine.nvim',
  'null%-ls.nvim',
  'nvim%-lspconfig',
  'nvim%-autopairs',
  'session%-lens',
  'neovim%-session%-manager',
}

-- require('pl.pretty')('hello', nil, 'world', { bye = 'world', true })

for _, path in ipairs(vim.api.nvim_get_runtime_file('', true)) do
  -- print(path)
  for _, name in ipairs(matchers) do
    if string.find(path, name) then
      table.insert(library, path)
    end
  end
end

table.insert(library, vim.loop.cwd())

for _, value in pairs(vim.split(os.getenv('LUA_LIB'), ';')) do
  table.insert(library, value)
end

local settings = {
  Lua = {
    runtime = {
      version = 'LuaJIT',
      path = {
        '?.lua',
        '?/init.lua',
        -- '?/?.lua',
      },
      pathStrict = false,
    },
    diagnostics = {
      globals = { 'vim' },
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
      enable = false,
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
})
