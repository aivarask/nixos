local path = '/etc/nixos/pack/local-lua-debugger-vscode'
require "dap".adapters.lua_local = {
	type = "executable",
	command = "node",
	args = { path .. "/extension/debugAdapter.js", },
	enrich_config = function(config, on_config)
		if not config["extensionPath"] then
			local c = vim.deepcopy(config)
			-- "module 'lldebugger' not found" errors in the dap-repl when trying to launch a debug session
			c.extensionPath = path
			on_config(c)
		else
			on_config(config)
		end
	end,
}
