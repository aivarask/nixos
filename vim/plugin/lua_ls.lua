-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
-- https://github.com/LuaLS/lua-language-server/wiki/Settings
local library = {
  -- TODO: Check lua_ls changes in lspconfig configuration
  -- vim.env.VIMRUNTIME,
  vim.loop.cwd(),
}
-- NOTE: % is escape char in Lua
local matchers = {
  'hover%.nvim$',
  'goto%-preview',
  'auto%-session',
  'flatten%-nvim',
  'lsp%-overloads',
  'lsp_signature.nvim',
  'lualine.nvim',
  'neodev%-nvim',
  'neotest$',
  'neotest%-playwright$',
  'neotest%-plenary$',
  'neotest%-vitest$',
  'neovim%-session%-manager',
  'null%-ls.nvim',
  'nvim%-autopairs',
  'nvim%-cmp',
  'nvim%-dap%-python',
  'nvim%-dap%-ui',
  'nvim%-dap%-virtual%-text',
  'nvim%-dap%-vscode%-js',
  'nvim%-dap',
  'nvim%-lspconfig',
  'nvim%-treesitter$',
  'osv',
  'project.nvim',
  'session%-lens',
  'tabline.nvim',
  'telescope.nvim',
  'todo%-comments.nvim',
  'toggleterm.nvim',
  'trouble.nvim',
  'vimplugin%-nvim%-tree',
  'which%-key%-nvim',
}

-- require('pl.pretty')(vim.api.nvim_get_runtime_file('', true))

for _, path in ipairs(vim.api.nvim_get_runtime_file('', true)) do
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
