-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
-- https://github.com/LuaLS/lua-language-server/wiki/Settings
local library = {
  vim.env.VIMRUNTIME,
  vim.loop.cwd(),
}

for _, value in pairs(vim.split(os.getenv('LUA_LIB') or '', ';')) do
  table.insert(library, value)
end

vim_shared = require('vim.shared') -- https://github.com/neovim/neovim
vim.lsp = require('vim.lsp')
vim.lsp.get_client_by_id(1)

busted = require('busted') -- https://github.com/lunarmodules/busted
inspect = require('inspect') -- https://github.com/kikito/inspect.lua#examples-of-use
assert(inspect(1) == '1')
assert(inspect({ 1, 2, 3, 4 }) == '{ 1, 2, 3, 4 }')
pretty = require('pl.pretty') -- https://github.com/lunarmodules/Penlight#module-overview
function pp(any)
  print(pretty(any))
end
plenary = require('plenary') -- https://github.com/nvim-lua/plenary.nvim
p = require('plenary.path')
luassert = require('luassert')
_debug = require('std._debug')(false) -- https://lua-stdlib.github.io/_debug/
version = require('std._debug.version')
--

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
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings.Lua, settings)
      client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
    end
    return true
  end,
})

-- NOTE: % is escape char in Lua

-- local matchers = {
--   -- 'hover%.nvim$',
--   -- 'goto%-preview',
--   -- 'auto%-session',
--   -- 'flatten%-nvim',
--   -- 'lsp%-overloads',
--   -- 'lsp_signature.nvim',
--   -- 'lualine.nvim',
--   -- 'neodev%-nvim',
--   -- 'neotest$',
--   -- 'neotest%-playwright$',
--   -- 'neotest%-plenary$',
--   -- 'neotest%-vitest$',
--   -- 'neovim%-session%-manager',
--   -- 'null%-ls.nvim',
--   -- 'nvim%-autopairs',
--   -- 'nvim%-cmp',
--   -- 'nvim%-dap%-python',
--   -- 'nvim%-dap%-ui',
--   -- 'nvim%-dap%-virtual%-text',
--   -- 'nvim%-dap%-vscode%-js',
--   -- 'nvim%-dap',
--   -- 'nvim%-lspconfig',
--   -- 'nvim%-treesitter$',
--   -- 'osv',
--   -- 'project.nvim',
--   -- 'session%-lens',
--   -- 'tabline.nvim',
--   -- 'telescope.nvim',
--   -- 'todo%-comments.nvim',
--   -- 'toggleterm.nvim',
--   -- 'trouble.nvim',
--   -- 'vimplugin%-nvim%-tree',
--   -- 'which%-key%-nvim',
-- }

-- for _, path in ipairs(vim.api.nvim_get_runtime_file('', true)) do
--   for _, name in ipairs(matchers) do
--     if string.find(path, name) then
--       table.insert(library, path)
--     end
--   end
-- end
