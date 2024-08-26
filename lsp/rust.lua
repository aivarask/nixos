local ftmap = require("null-ls.builtins._meta.filetype_map").rust
local rust = {
	formatting = { "dprint", "leptosfmt", "rustfmt" },
}
require("null-ls").register {
	-- require('null-ls.builtins.formatting.rustfmt'),
}

local rust_analyzer = require "lspconfig.server_configurations.rust_analyzer"
require("lspconfig").rust_analyzer.setup {}

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = "Format",
	desc = "rustfmt",
	pattern = { "*.rs" },
	callback = function() vim.lsp.buf.format() end,
})

-- https://romangeber.com/blog/tech/nvim_rust_debugger
-- https://github.com/vadimcn/codelldb
-- https://github.com/mrcjkb/rustaceanvim
-- after/ftplugin/rust.lua

local dap = require "dap"
local liblldb = os.getenv "LD_LIBRARY_PATH"

dap.adapters.codelldb = function(cb, config)
	if config.preLaunchTask then vim.fn.system(config.preLaunchTask) end
	local adapter = {
		type = "server",
		port = "${port}",
		host = "127.0.0.1",
		executable = {
			command = "codelldb",
			args = { "--liblldb", liblldb, "--port", "${port}" },
		},
	}
	cb(adapter)
end

dap.configurations.rust = {
	{
		name = "launch main",
		type = "codelldb",
		request = "launch",
		preLaunchTask = "cargo build",
		program = function() return vim.fn.getcwd() .. "/target/debug/main" end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
}
