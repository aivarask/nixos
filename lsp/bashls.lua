return {
	-- name = "BASHLS",
	filetypes = { 'sh', 'bash', 'zsh' },
	cmd = { 'bash-language-server', 'start' },
	-- settings = {
	-- 	bashIde = {
	-- 		globPattern = '*@(.sh|.inc|.bash|.command|.zsh)',
	-- 		-- shellcheckArguments = { '--shell=bash' },
	-- 	},
	-- },
}
