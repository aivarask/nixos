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


require('auto-session').setup({
	allowed_dirs = { '/etc/nixos' },
	log_level = vim.log.levels.ERROR,
})

require('flatten').setup {}

require('colorizer').setup({})
if vim.uv.os_getenv('WAYLAND_DISPLAY') then
	require('image').setup({ backend = 'kitty' }) -- https://raw.githubusercontent.com/3rd/image.nvim/refs/heads/master/README.md
end

require('mini.icons').setup(
	{
  -- Icon style: 'glyph' or 'ascii'
  style = 'glyph',

  -- Customize per category. See `:h MiniIcons.config` for details.
  default   = {},
  directory = {},
  extension = {},
  file      = {},
  filetype  = {},
  lsp       = {},
  os        = {},

  -- Control which extensions will be considered during "file" resolution
  use_file_extension = function(ext, file) return true end,
}
)
require('nvim-web-devicons').setup({
	override = {
		['nix'] = { icon = '', color = '#ff0000', cterm_color = '110', name = 'Nix' },
	},
})

require('fidget').setup({})
require('notify').setup({
	top_down = false,
})
vim.notify = require('notify')
