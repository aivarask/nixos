local format = vim.api.nvim_create_augroup("_format", {})
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = format,
	pattern = { [[*\(.vim\|.lua\)\@<!]] },
	desc = "vim.lsp.buf.format",
	callback = function()
		print("regular")
		vim.lsp.buf.format()
	end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = format,
	pattern = {
		"*.lua",
		"*.html",
		"*.xml",
		"*.twig",
	},
	desc = "vim.lsp.buf.format null-ls",
	callback = function()
		vim.lsp.buf.format({ name = "null-ls" })
	end,
})
