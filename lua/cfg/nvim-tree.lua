require('nvim-tree').setup({
	view = { width = 25, signcolumn = 'no' },
	git = { enable = true },
	sync_root_with_cwd = true,
	update_focused_file = { enable = true, update_root = true },
	ui = { confirm = { trash = false } },
	renderer = {
		hidden_display = 'all',
		icons = {
			git_placement = 'after',
		},
	},
	on_attach = function(bufnr)
		require('nvim-tree.api').config.mappings.default_on_attach(bufnr)
	end,
})

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
	{ 'qq', [[:NvimTreeToggle<CR>]], noremap = true },
	{ 'qw', [[:NvimTreeCollapse<CR>]] },
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
