local library = {
  vim.env.VIMRUNTIME,
  '${3rd}/luv/library',
  vim.env.LUA_LIB,
}

for i = #library, 1, -1 do
  local value = library[i]
  if string.find(value, 'myNeovimPackages') then
    table.remove(library, i)
  end
end
for _, name in ipairs({
  'which',
  'nio',
  'plenary.nvim',
  'notify',
  'fidget',
  'devicons',
  'none',
  'lspconfig',
  'cmp',
  'autopairs',
  'dap',
  'auto%-session',
  'persistent%-breakpoints',
  'telescope',
  'vimkind',
  'lualine',
  'toggleterm',
  'todo%-comments',
  'trouble.nvim',
  'outline',
  'hover',
  'lsp_signature',
  'file%-operations',
  'colorizer',
  'image.nvim',
  'nvim%-tree.lua',
  'goto%-preview',
  -- 'treesitter', -- disabled
}) do
  for _, path in ipairs(vim.api.nvim_list_runtime_paths()) do
    if string.find(path, name) then
      table.insert(library, path)
    end
  end
end

local c = require('lspconfig')
c.lua_ls.setup({
  settings = { -- https://luals.github.io/wiki/settings/
    Lua = {
      runtime = {
        version = 'LuaJIT',
        pathStrict = true,
        path = { 'lua/?/init.lua', 'lua/?.lua', '?/init.lua', '?.lua' },
      },
      workspace = { checkThirdParty = false, library = library },
    },
  },
})

local client = vim.lsp.get_clients({ name = 'lua_ls' })[1] or nil
if false and client ~= nil then
  client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
end
