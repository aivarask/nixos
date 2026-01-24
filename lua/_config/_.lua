---@diagnostic disable-next-line: missing-fields
require('which-key').setup({
	preset = 'helix',
	sort = { 'alphanum' },
	replace = {
		desc = {
			{ '<Plug>%(?(.*)%)?', '%1' },
			{ '^%+',              '' },
			{ '<[cC]md>',         '' },
			{ '<[cC][rR]>',       '' },
			{ '<[sS]ilent>',      '' },
			{ '^lua%s+',          '' },
			{ '^call%s+',         '' },
			{ '^:%s*',            '' },
		},
	},
})

-- require('nvim-surround').setup({})

require('auto-session').setup({
	allowed_dirs = { '/etc/nixos' },
	log_level = vim.log.levels.ERROR,
})

require('colorizer').setup({})
if vim.uv.os_getenv('DISPLAY') then
	require('image').setup({ backend = 'ueberzug' })
end

require('nvim-web-devicons').setup({
	override = {
		['nix'] = { icon = '', color = '#ff0000', cterm_color = '110', name = 'Nix' },
	},
})

require('fidget').setup({})
require('notify').setup({
	-- render = 'wrapped-compact',
	-- timeout = 1000,
	top_down = false,
})
vim.notify = require('notify')
