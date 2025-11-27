-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

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
	sort = {
		sorter = "name",
		folders_first = false,
		files_first = false,
	},
	sync_root_with_cwd = true,
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


vim.keymap.set('n', 'q', '<nop>')
vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', 'qq', [[:NvimTreeToggle<CR>]], { silent = true })
vim.keymap.set('n', 'qw', [[:NvimTreeCollapse<CR>]])
vim.keymap.set('n', 'qQ', function() tree.open({ find_file = true }) end,
	{ desc = 'tree.open find_file' })
vim.keymap.set('n', '[q', function()
		local node = require('nvim-tree.api').node
		node.navigate.sibling.prev()
		node.open.preview()
	end,
	{ desc = 'tree.sibling.prev' })
vim.keymap.set('n', ']q', function()
		local node = require('nvim-tree.api').node
		node.navigate.sibling.next()
		node.open.preview()
	end,
	{ desc = 'tree.sibling.next' })

tree = require('nvim-tree.api').tree
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'NvimTree',
	callback = function(ev)
		vim.keymap.set('n', 'l', require('nvim-tree.api').node.open.edit, { buffer = ev.buf })
		vim.keymap.set('n', '<C-l>', require('nvim-tree.api').tree.expand_all, { buffer = ev.buf })
		vim.keymap.set('n', 'h', require('nvim-tree.api').node.navigate.parent_close, { buffer = ev.buf })
		vim.keymap.set('n', '<C-h>', require('nvim-tree.api').tree.collapse_all, { buffer = ev.buf })
	end,
})
