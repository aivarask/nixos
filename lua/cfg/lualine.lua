-- vim:fdl=3
require('lualine').setup({
	extensions = { 'quickfix', 'nvim-tree', 'fzf', 'toggleterm', 'man', 'trouble' },
	options = {
		icons_enabled = false,
		section_separators = { left = '', right = '' },
		disabled_filetypes = {
			statusline = {
				'NvimTree',
				'Outline',
				'neotest-summary',
				'neotest-output-panel',
				'dapui_scopes',
				'dapui_breakpoints',
				'dapui_stacks',
				'dapui_watches',
				'dap-repl',
				'dapui_console',
			},
			winbar = { 'NvimTree', 'neotest-summary', 'neotest-output-panel' },
		},
	},
	tabline = {
		lualine_a = {
			require('auto-session.lib').current_session_name,
			'tabs',
		},
		lualine_b = {
			{ 'buffers', show_filename_only = true, max_length = vim.o.columns * 4 / 5, mode = 0 },
		},
		lualine_z = {
			'searchcount',
		},
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = {
			function()
				local p = vim.fn.expand('%:p')
				return p:gsub('/nix/store/[%a%d]+-', ''):gsub(vim.uv.cwd() .. '/' or '', '')
			end,
		},
		lualine_c = {
			-- { "filename", path = 2, },
		},
		lualine_x = {
			'encoding',
			'fileformat',
			'filetype',
		},
		lualine_y = { 'progress' },
		lualine_z = {
			'location',
			function()
				return vim.api.nvim_buf_line_count(0)
			end,
			function()
				return vim.fn.winwidth(0)
			end,
		},
	},
	inactive_sections = {
		lualine_c = {},
		lualine_x = {},
	},
})
