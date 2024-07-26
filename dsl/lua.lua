local getLibrary = function()
  local library = {
    vim.env.VIMRUNTIME,
    "${3rd}/luv/library",
    "/root/one-small-step-for-vimkind",
  }

  -- LUA_LIB
  local lualib = vim.split(os.getenv 'LUA_LIB' or '', ';')
  for index, value in ipairs(lualib) do
    table.insert(library, value)
  end

  -- plugins
  for _, path in ipairs(vim.api.nvim_list_runtime_paths()) do
    for _, name in ipairs {
      'plenary.nvim',
      'nvim%-ts%-context%-commentstring',
      'nvim%-lspconfig', 'nvim%-cmp', 'none%-ls.nvim', 'lsp_signature.nvim', 'SchemaStore.nvim', 'outline.nvim',
      'iron.nvim',
      'neotest', 'neotest%-phpunit', 'neotest%-plenary', 'neotest%-python',
      'nvim%-dap', 'nvim%-dap%-ui',
      'sqlite.lua',
      'gitsigns.nvim', 'neogit',
      'which%-key.nvim',
    } do
      if string.find(path, name) then
        table.insert(library, path)
      end
    end
  end

  return library
end

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
require 'lspconfig'.lua_ls.setup {
  settings = { -- https://luals.github.io/wiki/settings/
    Lua = {
      runtime = {
        version = 'LuaJIT',
        pathStrict = false,
        path = {
          "lua/?/init.lua",
          "lua/?.lua",
          "?/init.lua",
          "?.lua",
        },
      },
      workspace = {
        checkThirdParty = false,
        library = getLibrary(),
      },
      -- .luarc.json
    },
  },
}

vim.api.nvim_create_autocmd({ 'BufWritePre' },
  {
    group = 'Format',
    desc = 'lua',
    pattern = { '*.lua' },
    callback = function() vim.lsp.buf.format() end,
  })
