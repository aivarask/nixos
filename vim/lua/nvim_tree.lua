require("nvim-tree").setup({
	-- https://github.com/kyazdani42/nvim-tree.lua
	-- https://github.com/ahmedkhalf/project.nvim#-features
	sync_root_with_cwd = true,
	respect_buf_cwd = false,
	update_focused_file = {
		enable = true,
		update_root = true,
	},
	diagnostics = {
		enable = true,
	},
})
