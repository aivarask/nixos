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
      'nvim%-cmp',
      'nvim%-lspconfig',
      'none%-ls.nvim',
      'neotest',
      'lsp_signature.nvim',
      'SchemaStore.nvim',
      'nvim%-ts%-context%-commentstring'
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

vim.api.nvim_create_autocmd({ 'BufWritePre' },
  {
    group = 'Format',
    desc = 'lua',
    pattern = { '*.lua' },
    callback = function() vim.lsp.buf.format() end,
  })

-- https://github.com/tomblind/local-lua-debugger-vscode
require('dap').adapters["local-lua"] = {
  type = "executable",
  command = "node",
  args = { "/root/local-lua-debugger-vscode/extension/debugAdapter.js" },
  enrich_config = function(config, on_config)
    if not config["extensionPath"] then
      local c = vim.deepcopy(config)
      -- "module 'lldebugger' not found" errors in the dap-repl when trying to launch a debug session
      c.extensionPath = "/root/local-lua-debugger-vscode/"
      on_config(c)
    else
      on_config(config)
    end
  end,
}

require("dap").configurations.lua = {
  {
    type = "local-lua",
    request = "launch",
    name = "local-lua launch",
    port = 9003,
    program = {
      lua = "luajit",
      file = "${file}",
    },
    cwd = "${workspaceFolder}",
  },
}
