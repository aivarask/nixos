return {
	filetypes = { 'javascript', 'typescript' },
	-- https://github.com/microsoft/TypeScript
	-- https://github.com/typescript-language-server/typescript-language-server
	-- cmd = { '/etc/nixos/node_modules/.bin/typescript-language-server', '--stdio' },
	cmd = { 'typescript-language-server', '--stdio' },
	root_dir = vim.fs.root(0, { 'package.json' }),
	init_options = { hostInfo = 'neovim' },
}
