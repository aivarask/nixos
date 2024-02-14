local getLibrary = function()
  local library = {
    vim.env.VIMRUNTIME,
    "${3rd}/luv/library",
  }

  -- LUA_LIB
  local lualib = vim.split(os.getenv('LUA_LIB') or '', ';')
  for index, value in ipairs(lualib) do
    table.insert(library, value)
  end

  -- plugins
  for _, path in ipairs(vim.api.nvim_list_runtime_paths()) do
    for _, name in ipairs({
      'plenary.nvim',
      'nvim%-lspconfig',
      'none%-ls.nvim',
      'lsp_signature.nvim',
      'nvim%-cmp',
    }) do
      if string.find(path, name) then
        table.insert(library, path)
      end
    end
  end

  return library
end

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
require('lspconfig').lua_ls.setup({
  settings = { -- https://luals.github.io/wiki/settings/
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      workspace = {
        checkThirdParty = false,
        library = getLibrary(),
      },
    },
  },
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*.lua' },
  callback = function() vim.lsp.buf.format({ filter = function(client) return client.name == 'lua_ls' end }) end,
})
