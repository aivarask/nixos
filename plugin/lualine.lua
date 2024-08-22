require("lualine").setup { --- @see lualine
	options = {
		disabled_filetypes = {
			statusline = { "NvimTree", "neotest-summary", "neotest-output-panel" },
			winbar = { "NvimTree", "neotest-summary", "neotest-output-panel" },
			"dapui_watches",
			"dapui_breakpoints",
			"dapui_scopes",
			"dapui_console",
			"dapui_stacks",
			"dap-repl",
		},
	},
	tabline = {
		lualine_a = {},
		lualine_b = {
			{
				"buffers",
				show_filename_only = true,
				max_length = vim.o.columns * 4 / 5,
				mode = 4,
			},
		},
		lualine_y = {
			"tabs",
			require("auto-session.lib").current_session_name,
		},
		lualine_z = {
			"searchcount",
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { vim.uv.cwd },
		lualine_c = {
			{ "filename", path = 1 },
			{
				--- @see https://github.com/arkav/lualine-lsp-progress
				"lsp_progress",
				display_components = { "lsp_client_name", "spinner", { "percentage" } },
				spinner_symbols = { "🌑 ", "🌒 ", "🌓 ", "🌔 ", "🌕 ", "🌖 ", "🌗 ", "🌘 " },
			},
		},
		lualine_x = {
			"encoding",
			"fileformat",
			"filetype",
		},
		lualine_y = { "progress" },
		lualine_z = {
			"location",
			function() return vim.api.nvim_buf_line_count(0) end,
			function() return vim.fn.winwidth(0) end,
		},
	},
	inactive_sections = {
		lualine_c = { "filename" },
		lualine_x = {
			"location",
			function() return vim.api.nvim_buf_line_count(0) end,
		},
	},
	extensions = { "quickfix", "nvim-tree", "fzf", "toggleterm", "man", "trouble" },
}
