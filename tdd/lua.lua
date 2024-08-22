-- https://github.com/tomblind/local-lua-debugger-vscode
require("dap").adapters.lua = {
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
local dap = require "dap"
dap.set_log_level "DEBUG"
-- https://github.com/jbyuki/one-small-step-for-vimkind/blob/main/doc/osv.txt
dap.adapters.nlua = function(callback, config) callback { type = "server", host = "127.0.0.1", port = 8086 } end

local osv = require "osv"

---@see https://zignar.net/2023/06/10/debugging-lua-in-neovim/

dap.configurations.lua = {
	-- {
	--   type = 'nlua',
	--   request = 'attach',
	--   name = "nlua attach",
	-- },
	{
		type = "lua",
		request = "launch",
		name = "lua launch",
		port = 9003,
		program = {
			lua = "luajit",
			file = "${file}",
		},
		cwd = "${workspaceFolder}",
	},
}
