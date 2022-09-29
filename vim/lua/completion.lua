local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

require("pairs")

local luasnip = require("luasnip")

luasnip.filetype_extend("typescript", { "javascript" })
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").load({ paths = "/etc/nixos/vim/lua/snippets" })

local M = {}

M.reload = function()
	require("plenary.reload").reload_module("completion", true)
	-- require("luasnip").cleanup()
	-- require("luasnip.loaders.from_vscode").lazy_load()
	-- require("luasnip.loaders.from_vscode").load({ paths = "/etc/nixos/vim/lua/snippets" })
	print("completion reloaded")
end

M.greet = function()
	print("hello h")
end

local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	formatting = {
		format = require("lspkind").cmp_format({
			mode = "symbol_text",
			maxwidth = 50,
			before = function(_, vim_item)
				return vim_item
			end,
		}),
	},
	preselect = cmp.PreselectMode.None,

	mapping = {
		["<PageUp>"] = cmp.mapping.scroll_docs(-4),
		["<PageDown>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete({}), { "i", "c" }),
		["<C-e>"] = cmp.mapping(cmp.mapping.abort(), { "i", "c" }),
		["<CR>"] = cmp.mapping(
			cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			}),
			{ "i", "c" }
		),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s", "c" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s", "c" }),
		["<C-b>"] = cmp.mapping.complete({
			config = {
				sources = {
					{ name = "luasnip" },
				},
			},
		}),
	},

	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		-- { name = "luasnip" },
		{ name = "path" },
		-- { name = "emoji" },
		-- { name = "treesitter" },
	}),
})

cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})

cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
		-- FIX: not working :%s/
		-- { name = "buffer" },
	}, {
		{ name = "cmdline" },
		-- FIX: not working :%s/
		-- { name = "buffer" },
	}),
})

return M
