-- vim:fdl=4

-- local nls = require('null-ls')
-- nls.register({
-- 	-- nls.builtins.diagnostics.dotenv_linter,
-- 	-- nls.builtins.diagnostics.zsh,
-- 	nls.builtins.formatting.shellharden,
-- 	nls.builtins.formatting.shfmt,
-- 	nls.builtins.hover.printenv,
-- })

--   -- sh = {
--   --   diagnostics = { "dotenv_linter" },
--   --   formatting = { "shellharden", "shfmt" },
--   --   hover = { "printenv" }
--   -- },

-- local c = require('lspconfig')
-- c.bashls.setup({
-- 	filetypes = { 'sh', 'bash', 'zsh' },
-- 	settings = { bashIde = { globPattern = '*@(.sh|.inc|.bash|.command|.zsh)' } },
-- })

-- https://github.com/koalaman/shellcheck?tab=readme-ov-file#gallery-of-bad-code
-- https://github.com/bash-lsp/bash-language-server/blob/main/server/src/config.ts
-- https://github.com/koalaman/shellcheck#gallery-of-bad-code
vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'sh', 'bash', 'zsh' },
	callback = function()
		vim.lsp.start({
			name = 'bash-language-server',
			cmd = { 'bash-language-server', 'start' },
			settings = {
				bashIde = {
					globPattern = [[*@(.sh|.inc|.bash|.command|.zsh)]],
					-- globPattern = '*@(.sh|.inc|.bash|.command|.zsh)',
					-- shellcheckArguments = { '--shell=bash' },
				},
			},
		})
	end,
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = { '*.sh', '*.bash', '*.zsh' },
	desc = 'vim.lsp.buf.format bash-language-server 1000',
	callback = function()
		vim.lsp.buf.format({
			name = 'bash-language-server',
		})
	end,
})
