require('nvim-tree').setup({
	view = { width = 25, signcolumn = 'no' },
	git = { enable = true },
	sync_root_with_cwd = true,
	update_focused_file = { enable = true, update_root = true },
	ui = { confirm = { trash = false } },
	on_attach = function(bufnr)
		require('nvim-tree.api').config.mappings.default_on_attach(bufnr)
	end,
})

local node = require('nvim-tree.api').node
local tree = require('nvim-tree.api').tree
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
