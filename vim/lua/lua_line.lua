-- https://github.com/kdheepak/tabline.nvim#lualine-tabline-support
require("tabline").setup({ enable = false })
-- https://github.com/nvim-lualine/lualine.nvim
require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { 
      require("auto-session-library").current_session_name,
      "mode" },
		lualine_b = { "branch", "diff", "diagnostics", vim.loop.cwd },
		lualine_c = { { "filename", path = 1 }, "lsp_progress" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {
		lualine_a = {},
		lualine_b = {},
		-- lualine_c = {
		-- 	{
		-- 		"buffers",
		-- 		show_filename_only = false,
		-- 		buffers_color = {
		-- 			-- active = "lualine_{section}_normal", -- Color for active buffer.
		-- 			-- inactive = "lualine_{section}_inactive", -- Color for inactive buffer.
		-- 		},
		-- 		symbols = {
		-- 			modified = "+", -- Text to show when the buffer is modified
		-- 			alternate_file = "#", -- Text to show to identify the alternate file
		-- 			directory = "", -- Text to show when the buffer is a directory
		-- 		},
		-- 	},
		-- },
		lualine_c = { require("tabline").tabline_buffers },
		lualine_x = { require("tabline").tabline_tabs },
		lualine_y = {},
		lualine_z = {},
	},
	extensions = { "quickfix" },
})
