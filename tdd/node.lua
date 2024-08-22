-- nvim-dap-vscode-js
require("dap-vscode-js").setup {
	debugger_path = "/root/vscode-js-debug",
	adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
}
require("dap").configurations.javascript = {
	{
		type = "pwa-node",
		request = "launch",
		name = "pwa-node launch file",
		program = "${file}",
		cwd = "${workspaceFolder}",
	},
}
