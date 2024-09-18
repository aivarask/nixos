local dap = require "dap"

dap.adapters.nlua = function(callback, config)
	callback { type = 'server', host = config.host or "127.0.0.1", port = config.port or 8086, }
end


dap.configurations.lua = {
	{
		type = 'nlua',
		request = 'attach',
		name = "Attach to running Neovim instance",
	},
	-- 	{
	-- 		type = "lua",
	-- 		request = "launch",
	-- 		name = "lua launch",
	-- 		port = 9003,
	-- 		program = {
	-- 			lua = "luajit",
	-- 			file = "${file}",
	-- 		},
	-- 		cwd = "${workspaceFolder}",
	-- 	},
}

osv = require 'osv'
-- osv.launch { port = 8086, }
