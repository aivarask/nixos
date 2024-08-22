local clients = vim.lsp.get_clients { name = 'lua_ls', }
local client = clients[1]
local pretty = require 'pl.pretty'

local add_lualib = function(library)
  local lualib = vim.split(os.getenv 'LUA_LIB' or '', ';')
  for k, v in pairs(lualib) do
    local found = false
    for j, lib_v in pairs(library) do
      if v == lib_v then
        found = true
      end
    end
    if not found then table.insert(library, v) end
  end
end

local add_runtimes = function(library)
  for i = #library, 1, -1 do
    local value = library[i]
    if string.find(value, 'myNeovimPackages') then
      table.remove(library, i)
    end
  end

  local from_runtime = {
    'nvim%-cmp', 'nvim%-autopairs',
    'neotest',
    -- 'telescope.nvim',
    'which%-key.nvim',
    -- 'gitsigns.nvim',
    -- 'fold%-preview.nvim',
  }
  for _, name in ipairs(from_runtime) do
    for _, path in ipairs(vim.api.nvim_list_runtime_paths()) do
      if string.find(path, name) then
        table.insert(library, path)
      end
    end
  end
end

local update = function()
  local library = client.config.settings.Lua.workspace.library
  add_lualib(library)
  add_runtimes(library)
  client.notify("workspace/didChangeConfiguration", { settings = client.config.settings, })
end

if vim.tbl_isempty(clients) then
  local library = {
    vim.env.VIMRUNTIME,
    "${3rd}/luv/library",
  }
  add_lualib(library)
  add_runtimes(library)
  require 'lspconfig'.lua_ls
      .setup {
        settings = { -- https://luals.github.io/wiki/settings/
          Lua = {
            runtime = { version = 'LuaJIT', pathStrict = true, path = { "lua/?/init.lua", "lua/?.lua", "?/init.lua", "?.lua", }, },
            workspace = { checkThirdParty = false, library = library, },
          },
        },
      }



  -- vim.api.nvim_create_autocmd({ 'BufWritePre', },
    -- { desc = 'lua_ls', pattern = { '*.lua', }, callback = function() vim.lsp.buf.format { async = true, } end, })

  vim.api.nvim_create_autocmd({ 'BufWritePost', },
    {
      desc = 'lua_ls',
      pattern = { '.luarc.json', },
      callback = function()
        local cl = vim.lsp.get_clients { name = 'lua_ls', }[1]
        if cl ~= nil then
          print(cl.name, 'workspace/didChangeConfiguration')
          cl.notify("workspace/didChangeConfiguration", {})
        end
      end,
    })
else
  update()
end

vim.api.nvim_create_augroup('lua_ls', {})
vim.api.nvim_create_autocmd('BufWritePost',
  {
    group = 'lua_ls',
    pattern = { 'plugin/lua.lua', },
    desc = 'workspace/didChangeConfiguration',
    callback = function()
      local clients = vim.lsp.get_clients { name = 'lua_ls', }
      local client = clients[1]

      if client ~= nil then
        local library = client.config.settings.Lua.workspace.library
        add_runtimes(library)
        client.notify("workspace/didChangeConfiguration", { settings = client.config.settings, })
        print 'workspace/didChangeConfiguration'
        -- require 'telescope.pickers'
      end
    end,
  })
