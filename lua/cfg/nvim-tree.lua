require('nvim-tree').setup({
	view = { width = 25, signcolumn = 'no' },
	git = { enable = true },
	sync_root_with_cwd = true,
	update_focused_file = { enable = true, update_root = true },
	ui = { confirm = { trash = false } },
	on_attach = function(bufnr)
		require('nvim-tree.api').config.mappings.default_on_attach(bufnr)
	end,
	renderer = {
		icons = {
			git_placement = 'after',
		},
	},
})

local node = require('nvim-tree.api').node
require('which-key').add({
	{ 'qq', [[:NvimTreeToggle<CR>]], noremap = true },
	{ 'qw', [[:NvimTreeCollapse<CR>]] },
	{
		'[q',
		function()
			node.navigate.sibling.prev()
			node.open.preview()
		end,
		desc = 'tree.prev',
	},
	{
		']q',
		function()
			node.navigate.sibling.next()
			node.open.preview()
		end,
		desc = 'tree.next',
	},
})
