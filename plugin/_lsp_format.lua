vim.api.nvim_create_augroup("Format", {  })
vim.api.nvim_create_autocmd({ "BufWritePre", }, {
	group = "Format",
	pattern = {
		"*.c", "*.h", "*.cpp",
		"*.css",
		"*.go", "*.templ",
		"*.md",
		"*.nix",
		"*.js", "*.ts",
		"*.php",
		"*.py",
		"*.rs",
		"*.sh", "*.bash", "*.zsh",
		"*.sql",
		"*.lua",
		"*.vim",
		"*.json", "*.jsonc",
		"*.yaml", "*.yml",
		"*.zig",
	},
	callback = function() vim.lsp.buf.format() end,
})

vim.api.nvim_create_autocmd({ "BufWritePre", }, {
	group = "Format",
	pattern = { "*.html", "*.xml", "*.twig", },
	desc = "null-ls",
	callback = function()
		vim.lsp.buf.format {
			async = true,
			filter = function(client) return client.name == "null-ls" end,
		}
	end,
})

vim.api.nvim_create_autocmd({ "BufWritePost", }, {
	group = vim.api.nvim_create_augroup("LspRestart", {}),
	desc = "lua_ls notify workspace/didChangeConfiguration",
	pattern = { ".luarc.json", },
	callback = function()
		local cl = vim.lsp.get_clients { name = "lua_ls", }[1]
		if cl ~= nil then
			print(cl.name, "workspace/didChangeConfiguration")
			cl.notify("workspace/didChangeConfiguration", {})
		end
	end,
})

