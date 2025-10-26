local wezterm = require('wezterm')
local config = wezterm.config_builder()

-- wezterm connect unix
config.default_gui_startup_args = { 'connect', 'unix' }
config.font = wezterm.font({ family = 'monospace', weight = 'Regular' })
config.font_size = 12.0
-- config.dpi = 288
config.warn_about_missing_glyphs = false
config.hide_tab_bar_if_only_one_tab = true
config.enable_scroll_bar = true
-- config.prefer_to_spawn_tabs = true;
config.exit_behavior = 'Close'

-- https://wezterm.org/config/lua/config/index.html
config.color_scheme = 'gruvbox_material_dark_hard'
config.color_schemes = {
	['gruvbox_material_dark_hard'] = {
		foreground = '#D4BE98',
		background = '#1D2021',
		cursor_bg = '#D4BE98',
		cursor_border = '#D4BE98',
		cursor_fg = '#1D2021',
		selection_bg = '#D4BE98',
		selection_fg = '#3C3836',
		ansi = { '#1d2021', '#ea6962', '#a9b665', '#d8a657', '#7daea3', '#d3869b', '#89b482', '#d4be98' },
		brights = { '#eddeb5', '#ea6962', '#a9b665', '#d8a657', '#7daea3', '#d3869b', '#89b482', '#d4be98' },
	},
}
config.use_fancy_tab_bar = true
config.window_frame = {
	font = wezterm.font { family = 'Roboto', weight = 'Bold' },
	font_size = 18.0,
	active_titlebar_bg = '#333333',
	inactive_titlebar_bg = '#333333',
}
config.window_padding = {
	left = 2,
	right = 2,
	top = 0,
	bottom = 0,
}

-- https://wezterm.org/config/key-tables.html
config.keys = {
	{ key = 'L', mods = 'CTRL', action = wezterm.action.ShowDebugOverlay },
	{ key = 'P', mods = 'CTRL', action = wezterm.action.ActivateCommandPalette, },
}

config.launch_menu = {
	{
		args = { 'top' },
	},
	{
		label = 'Bash',
		args = { 'bash', '-l' },
		cwd = '/etc/nixos',
		-- set_environment_variables = { },
	},
}

-- local f = io.open('/root/wezterm.txt', 'w+')
-- f:write(wezterm.version .. '\n')
-- io.close(f)

return config
