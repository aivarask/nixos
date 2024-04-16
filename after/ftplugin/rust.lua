vim.g.rustaceanvim = function()
  -- Update this path
  -- local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/'
  local codelldb_path = 'codelldb'
  local liblldb_path = 'lldb'

  local cfg = require('rustaceanvim.config')
  return {
    server = {
      on_attach = on_attach,
    },
    dap = {
      adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
    },
  }
end

