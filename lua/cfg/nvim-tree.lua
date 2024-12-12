require('nvim-tree').setup({
	on_attach = function(bufnr)
		require('nvim-tree.api').config.mappings.default_on_attach(bufnr)
	end,
	git = { enable = false },
	view = { width = 25, signcolumn = 'no' },
	renderer = {
		indent_width = 1,
		hidden_display = 'all',
		icons = {
			git_placement = 'after',
		},
	},
	sync_root_with_cwd = false,
	root_dirs = { '/etc/nixos' },
	update_focused_file = {
		enable = false,
		update_root = {
			enable = false,
			ignore_list = {},
		},
		exclude = false,
	},
	ui = {
		confirm = {
			remove = true,
			trash = false,
			default_yes = false,
		},
	},
})
tree = require('nvim-tree.api').tree
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'NvimTree',
	callback = function(ev)
		require('which-key').add({
			{ 'l', require('nvim-tree.api').node.open.edit, buffer = ev.buf },
			{ '<C-l>', require('nvim-tree.api').tree.expand_all, buffer = ev.buf },
			{ 'h', require('nvim-tree.api').node.navigate.parent_close, buffer = ev.buf },
			{ '<C-h>', require('nvim-tree.api').tree.collapse_all, buffer = ev.buf },
		})
	end,
})

require('which-key').add({
	{ 'q', '<nop>' },
	{ 'Q', '<nop>' },
	{ 'qq', [[:NvimTreeToggle<CR>]] },
	{ 'qw', [[:NvimTreeCollapse<CR>]] },
	{
		'qQ',
		function()
			tree.open({ find_file = true } --[[@as ApiTreeOpenOpts]])
		end,
		desc = 'tree.open find_file',
	},
	{
		'[q',
		function()
			local node = require('nvim-tree.api').node
			node.navigate.sibling.prev()
			node.open.preview()
		end,
		desc = 'tree.prev',
	},
	{
		']q',
		function()
			local node = require('nvim-tree.api').node
			node.navigate.sibling.next()
			node.open.preview()
		end,
		desc = 'tree.next',
	},
})
