require('telescope').setup({
	defaults = {
		layout_strategy = 'horizontal',
		-- layout_strategy = 'vertical',

		layout_config = { vertical = { width = 0.9 }, horizontal = { width = 0.9 } },
		vimgrep_arguments = {
			'rg',
			'--color=never',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'--smart-case',
			'--hidden',
			'--glob=!.git',
			'--glob=!*.lock',
			'--glob=!*/suckless/*.{h,diff}',
			'--glob=!public-resolvers.md',
			'--glob=!gruvbox.{yaml,toml}',
		},
	},
	extensions = {
		fzf = {
			-- 	fuzzy = true,                -- false will only do exact matching
			-- 	override_file_sorter = true, -- override the file sorter
			-- 	override_generic_sorter = true, -- override the generic sorter
			case_mode = 'smart_case', -- default "smart_case" or "ignore_case" or "respect_case"
		},
		manix = {
			cword = true,
		}
	},
})

require('telescope').load_extension('fzf')
-- require('telescope').load_extension('fzy_native')
-- require('telescope').load_extension('lazygit')
require('telescope').load_extension('manix')

local builtin = require('telescope.builtin')
