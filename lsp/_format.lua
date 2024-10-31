-- vim: foldlevel=4
local format = vim.api.nvim_create_augroup('_format', {})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	group = format,
	pattern = {
		-- '*.nix',
		'*.lua',
	},
	desc = 'vim.lsp.buf.format null-ls 1000',
	callback = function()
		vim.lsp.buf.format({
			-- async = true,
			name = 'null-ls',
			timeout_ms = 1000,
		})
	end,
})

-- vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
-- 	group = format,
-- 	-- pattern = { [[?*\(.vim\|.lua\|.nix\|sxhkdrc\)\@<!]] },
-- 	pattern = { [[?*\(.vim\|.lua\|.nix\|sxhkdrc\)\@<!]] },
-- 	desc = 'vim.lsp.buf.format',
-- 	callback = function()
-- 		vim.lsp.buf.format({ timeout_ms = 1000 })
-- 	end,
-- })
