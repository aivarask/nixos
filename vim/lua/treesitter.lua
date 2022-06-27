-- https://github.com/nvim-treesitter/nvim-treesitter
require("nvim-treesitter.configs").setup({
	context_commentstring = {
		enable = true,
		-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
	},
	highlight = {
		enable = true,
		-- https://github.com/nvim-treesitter/nvim-treesitter#available-modules
	},
	incremental_selection = {
		enable = true,
		-- https://github.com/nvim-treesitter/nvim-treesitter
		keymaps = {
			init_selection = "tt",
			node_incremental = "ti",
			scope_incremental = "ts",
			node_decremental = "td",
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
	autotag = {
		enable = true,
		-- filetypes = { "html", "xml" },
	},
})
