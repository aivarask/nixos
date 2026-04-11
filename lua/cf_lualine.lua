if not pcall(require, 'lualine') then
	return
end
local filetype_names = {
	NvimTree = 'tree'
}

require('lualine').setup({
	tabline = {
		lualine_a = { { 'tabs', mode = 2 }, },
		lualine_x = {},
		lualine_y = { { 'windows', filetype_names = filetype_names, } },
	},
	winbar = {
		lualine_a = {},
		lualine_b = {
			{
				'buffers',
				show_filename_only = false,
				max_length = vim.o.columns * 4 / 5,
				mode = 0,
				filetype_names = filetype_names,
			},
		},
		lualine_y = {},
		lualine_z = {}
	},
	inactive_winbar = {
		lualine_a = {},
		lualine_b = { 'filename', },
		lualine_x = {

		},
	},

	sections = {
		lualine_a = { 'searchcount', 'mode' },
		lualine_b = {
			function()
				local p = vim.fn.expand('%:p')
				return p:gsub('/nix/store/[%a%d]+-', ''):gsub(
					vim.uv.cwd() .. '/' or '', '')
			end,
			function() return vim.api.nvim_buf_line_count(0) end,
			'location',
		},
		lualine_c = {
		},
		lualine_x = { function()
			local separator = ''
			local lsps = ''
			for index, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
				lsps = client.config.name .. lsps
				if client:supports_method('textDocument/formatting') then
					lsps = lsps .. '[F]'
				end
				lsps = lsps .. separator
			end
			return lsps
		end
		},
		lualine_y = { 'filetype', },
		lualine_z = {
		},
	},
	inactive_sections = {},
	extensions = {
		'fzf',
		'man',
		'nvim-tree',
		'quickfix',
	},
	options = {
		icons_enabled = true,
		section_separators = { left = '', right = '' },
		component_separators = { left = '', right = '' },
		disabled_filetypes = {
			winbar = {
				'NvimTree',
			},
			statusline = {
				'NvimTree',
			},
		},
	},

})
