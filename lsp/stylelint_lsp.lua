return {
	cmd = { 'stylelint-lsp', '--stdio' },
	filetypes = { 'css', 'scss', 'less' },
	settings = {
    stylelintplus = {
			enable = true,
			autoFixOnFormat = true,
			autoFixOnSave = true,
			-- configFile = "/etc/nixos/sway/waybar/stylelintrc.json"
		}
	},
}
