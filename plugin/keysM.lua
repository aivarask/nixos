local wk = require "which-key"
wk.add {
	-- <M-k> lsp_signature toggle_key
	-- <M-s> lsp-overloads close_signature
	-- <M-s> switch
	-- <M-w> https//github.com/windwp/nvim-autopairs#fastwrap
	{ "<M-1>",      "<cmd>Telescope find_files default_text=Make\\ |\\ .mk<CR>", mode = { "n", "i", }, },
	{ "<M-c>",      "<cmd>Commentary<CR>",                                       mode = { "n", "i", "v", }, },
	{ "<M-e>1",     "<cmd>edit .luarc.json<CR>", },
	{ "<M-e><M-E>", "<cmd>edit plugin/keysM.lua<CR>", },
	{ "<M-e>d",     "<cmd>edit /etc/nixos/doc/nixos.txt<CR>", },
	{ "<M-e>f",     "<cmd>edit flake.nix<CR>", },
	{ "<M-e>i",     "<cmd>edit plugin/__init.lua<CR>", },
	{ "<M-e>k",     "<cmd>edit plugin/keys.lua<CR>", },
	{ "<M-e>l",     "<cmd>edit plugin/lua.lua<CR>", },
	{ "<M-e>L",     "<cmd>edit plugin/lualine.lua<CR>", },
	{ "<M-e>n",     "<cmd>edit lsp/~neotest.lua<CR>", },
	{ "<M-e>s",     "<cmd>edit " .. vim.env.SXHKDRC .. "<CR>", },
	{ "<M-e>t",     "<cmd>edit plugin/treesitter.lua<CR>", },
}

wk.add {
	{
		"?a",
		function() wk.show {} end,
		desc = "all",
	},
	{
		"??",
		function() wk.show { global = false, } end,
		desc = "w/o global",
	},
	{
		"?i",
		function() wk.show { mode = "i", } end,
		desc = "i",
	},
	{
		"?n",
		function() wk.show { mode = "n", } end,
		desc = "n",
	},
	{
		"?v",
		function() wk.show { mode = "v", } end,
		desc = "v",
	},
	{
		"?c",
		function() wk.show { mode = "c", } end,
		desc = "c",
	},
	{
		"?z",
		function() wk.show { keys = "/", } end,
		desc = "z",
	},
}
