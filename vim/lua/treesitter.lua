-- https://github.com/nvim-treesitter/nvim-treesitter
require("nvim-treesitter.configs").setup({
	context_commentstring = {
		enable = true,
		-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
	},
	highlight = {
		enable = true,
		disable = {
			-- "sh",
			-- "bash",
			-- --
			-- "typescript",
			-- "svelte",
		},
		-- https://github.com/nvim-treesitter/nvim-treesitter#available-modules
		-- TODO: Some todo
		-- FIX: This needs to be fixed
		-- additional_vim_regex_highlighting = true,
	},
	incremental_selection = {
		enable = true,
		-- https://github.com/nvim-treesitter/nvim-treesitter
		keymaps = {
			init_selection = "tt",
			node_incremental = "<Tab>",
			scope_incremental = "ti",
			node_decremental = "<S-Tab>",
		},
	},
	indent = {
		-- https://github.com/nvim-treesitter/nvim-treesitter#indentation
		enable = true,
	},
	matchup = {
		-- https://github.com/andymass/vim-matchup#tree-sitter-integration
		enable = true,
	},
	rainbow = {
		-- https://github.com/p00f/nvim-ts-rainbow
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
	},

	-- ## https://github.com/windwp/nvim-ts-autotag
	autotag = {
		enable = true,
	},
	-- -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
	textobjects = {
		select = {
			enable = true,

			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,

			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				-- you can optionally set descriptions to the mappings (used in the desc parameter of nvim_buf_set_keymap
				["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
			},
			-- You can choose the select mode (default is charwise 'v')
			selection_modes = {
				["@parameter.outer"] = "v", -- charwise
				["@function.outer"] = "V", -- linewise
				["@class.outer"] = "<c-v>", -- blockwise
			},
			-- If you set this to `true` (default is `false`) then any textobject is
			-- extended to include preceding xor succeeding whitespace. Succeeding
			-- whitespace has priority in order to act similarly to eg the built-in
			-- `ap`.
			include_surrounding_whitespace = true,
		},
	},
})
