local wezterm = require('wezterm')

local config = wezterm.config_builder()
-- https://wezterm.org/config/lua/wezterm/font.html
config.font = wezterm.font({ family = 'monospace', weight = 'Bold' })
config.font_size = 24.0
config.hide_tab_bar_if_only_one_tab = true
-- c.color_scheme = 'AdventureTime'
config.enable_scroll_bar = true
config.window_padding = {
	left = 2,
	right = 2,
	top = 0,
	bottom = 0,
}
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

local f = io.open('wezterm.txt', 'w+')
f:write(wezterm.version .. '\n')
io.close(f)

return config
