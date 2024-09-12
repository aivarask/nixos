local format = vim.api.nvim_create_augroup("format", {})
vim.api.nvim_create_autocmd({ "BufWritePre", }, {
	group = format,
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
		-- "*.vim",
		"*.json", "*.jsonc",
		"*.yaml", "*.yml",
		"*.zig",
	},
	desc = "vim.lsp.buf.format()",
	callback = function() vim.lsp.buf.format() end,
})

vim.api.nvim_create_autocmd({ "BufWritePre", }, {
	group = format,
	pattern = {
		"*.html", "*.xml", "*.twig",
	},
	desc = "vim.lsp.buf.format null-ls",
	callback = function()
		vim.lsp.buf.format {
			async = true,
			filter = function(client) return client.name == "null-ls" end,
		}
	end,
})
