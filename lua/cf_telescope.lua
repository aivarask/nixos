local lfs = require 'lfs'
local data = vim.fn.stdpath('data')
lfs.mkdir(data .. '/databases')

require('telescope').setup({
	defaults = {
		layout_strategy = 'flex',
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
		history = {
			path = data .. '/databases/telescope_history.sqlite3',
			limit = 100,
		}
	},
	extensions = {
		fzf = {
			fuzzy = true,                -- false will only do exact matching
			override_file_sorter = true, -- override the file sorter
			override_generic_sorter = true, -- override the generic sorter
			case_mode = 'smart_case',    -- default "smart_case" or "ignore_case" or "respect_case"
		},
		manix = {
			cword = true,
		}
	},
})
require("telescope").load_extension("notify")
require('telescope').load_extension('fzf')
