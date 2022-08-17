local dap = require("dap")

dap.defaults.fallback.terminal_win_cmd = "60vsplit new"
vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "🟡", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "🟢", texthl = "", linehl = "", numhl = "" })

-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#Javascript
dap.adapters.javascript = {
	type = "executable",
	command = "node",
	args = {
		-- os.getenv("HOME") .. "/vscode-node-debug2/out/src/nodeDebug.js",
		"/etc/nixos/misc/vscode-node-debug2/out/src/nodeDebug.js",
	},
}
dap.configurations.javascript = {
	{
		name = "Launch",
		type = "javascript",
		request = "launch",
		-- arg = {},
		program = "${workspaceFolder}/${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
	},
	-- {
	-- 	-- For this to work you need to make sure the node process is started with the `--inspect` flag.
	-- 	name = "Attach to process",
	-- 	type = "javascript",
	-- 	request = "attach",
	-- 	processId = require("dap.utils").pick_process,
	-- },
}

-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#javascript-firefox
dap.adapters.firefox = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/vscode-firefox-debug/dist/adapter.bundle.js" },
}

dap.configurations.typescript = {
	name = "Debug with Firefox",
	type = "firefox",
	request = "launch",
	reAttach = true,
	url = "http://localhost:3000",
	webRoot = "${workspaceFolder}",
	firefoxExecutable = "firefox",
}

-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#php
dap.adapters.php = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/vscode-php-debug/out/phpDebug.js" },
}
dap.configurations.php = {
	{
		type = "php",
		request = "launch",
		name = "Listen for Xdebug",
		port = 9000,
	},
}

-- https://github.com/jbyuki/one-small-step-for-vimkind#configuration
dap.configurations.lua = {
	{
		type = "nlua",
		request = "attach",
		name = "Attach to running Neovim instance",
		host = function()
			local value = vim.fn.input("Host [127.0.0.1]: ")
			if value ~= "" then
				return value
			end
			return "127.0.0.1"
		end,
		port = function()
			local val = tonumber(vim.fn.input("Port: "))
			assert(val, "Please provide a port number")
			return val
		end,
	},
}
dap.adapters.nlua = function(callback, config)
	callback({ type = "server", host = config.host, port = config.port })
end

local function debugJest(testName, filename)
	print("starting " .. testName .. " in " .. filename)
	dap.run({
		type = "node2",
		request = "launch",
		cwd = vim.fn.getcwd(),
		runtimeArgs = { "--inspect-brk", "jest", "--no-coverage", "-t", testName, "--", filename },
		sourceMaps = true,
		protocol = "inspector",
		skipFiles = { "<node_internals>/**/*.js" },
		console = "integratedTerminal",
		port = 9229,
	})
end

local function attach()
	print("attaching")
	dap.run({
		type = "node2",
		request = "attach",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		skipFiles = { "<node_internals>/**/*.js" },
	})
end

local function attachToRemote()
	print("attaching")
	dap.run({
		type = "node2",
		request = "attach",
		address = "127.0.0.1",
		port = 9229,
		localRoot = vim.fn.getcwd(),
		remoteRoot = "/root/app",
		sourceMaps = true,
		protocol = "inspector",
		skipFiles = { "<node_internals>/**/*.js" },
	})
end

return {
	debugJest = debugJest,
	attach = attach,
	attachToRemote = attachToRemote,
}
