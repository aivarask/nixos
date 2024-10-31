-- vim:fdl=4
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'html' },
	callback = function()
		vim.lsp.start({
			cmd = { 'vscode-html-language-server', '--stdio' },
			capabilities = capabilities,
			init_options = {
				provideFormatter = true,
				embeddedLanguages = { css = true, javascript = true },
				configurationSection = { 'html', 'css', 'javascript' },
			},
		})
	end,
})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = { '*.html' },
	desc = 'format vscode-html-language-server',
	callback = function()
		vim.lsp.buf.format({ name = 'vscode-html-language-server' })
	end,
})

require('lspconfig').twiggy_language_server.setup({ capabilities = capabilities })
require('null-ls').register({
	require('null-ls.builtins.formatting.prettierd').with({ filetypes = { 'twig' } }),
})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = { '*.twig' },
	desc = 'format prettier',
	callback = function()
		vim.lsp.buf.format({ name = 'null-ls' })
	end,
})

-- vim.api.nvim_create_autocmd('FileType', {
-- 	pattern = { 'html' },
-- 	callback = function()
-- 		-- c.htmx.setup({ filetypes = { 'html', 'templ', 'twig' } })
-- 		vim.lsp.start({ cmd = { 'htmx-lsp' } })
-- 	end,
-- })
