require('telescope').setup({
	defaults = {
		layout_strategy = 'vertical',
		layout_config = { vertical = { width = 0.9 } },
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
			-- '--ignore-file="/root/.config/git/ignore"',
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = 'smart_case', -- default "smart_case" or "ignore_case" or "respect_case"
		},
	},
})
require('telescope').load_extension('fzf')
require('telescope').load_extension('lazygit')

require('which-key').add({
	{ '<leader>t', group = 'Telescope', icon = '' },
	{ '<leader>ta', [[:Telescope autocommands<CR>]] },
	{ '<leader>tc', [[:Telescope commands<cr>]] },
	{ '<leader>td', [[:Telescope diagnostics<cr>]] },
	{ '<leader>tm', [[:Telescope manix<CR>]] },
	{ '<leader>tn', [[:Telescope notify<CR>]] },
	{ '<leader>to', [[:Telescope vim_options<CR>]] },
	{ '<leader>tp', [[:Telescope paths<CR>]] },
	{ '<leader>tr', [[:Telescope registers<CR>]] },
	{ '<leader>ts', [[:Telescope session-lens<CR>]] },
	{ '<leader>tS', [[:Telescope snippets<CR>]] },
	{ '<leader>tt', [[:Telescope<CR>]] },
})
