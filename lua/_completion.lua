--- @doc https://github.com/rafamadriz/friendly-snippets
local luasnip = require('luasnip') --- @see luasnip
require('luasnip.loaders.from_vscode').lazy_load({ exclude = { 'all' } })
require('luasnip.loaders.from_vscode').load({ paths = '/etc/nixos/share/vim/snippets' })

local cmp = require('cmp') --- @see nvim-cmp
--- @type cmp.ConfigSchema
local config = {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},

	sources = cmp.config.sources({
		{ name = 'nvim_lsp', group_index = 2 }, --- @see cmp-nvim-lsp
		{ name = 'path', group_index = 2 }, --- @see cmp-path
		-- { name = 'luasnip', group_index = 2, keyword_length = 2 },
		-- { name = "emoji", group_index = 2 }, --- @see cmp-emoji
		-- { name = 'buffer' }, --- @see https://github.com/hrsh7th/cmp-buffer
	}),

	mapping = {
		['<C-e>'] = cmp.mapping.abort(),
		['<C-y>'] = function(fallback)
			if cmp.visible() then
				cmp.confirm({
					-- select = true,
					-- behavior = cmp.ConfirmBehavior.Replace
				})
			else
				print('im CR')
				fallback()
			end
		end,
		['<C-u>'] = cmp.mapping.scroll_docs(-4),
		['<C-d>'] = cmp.mapping.scroll_docs(4),
		['<C-n>'] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				cmp.complete()
			end
		end,
		['<C-p>'] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				cmp.complete()
			end
		end,
		-- ['<C-k>'] = cmp.select_next_item({ behavior = cmp.SelectBehavior.Select }),
	},
	-- mapping = cmp.mapping.preset.insert({}),
}

cmp.setup(config)

-- cmp.setup.cmdline(
-- 	{ "/", "?" }, --- @see cmp-cmdline https://github.com/hrsh7th/cmp-cmdline
-- 	{ mapping = cmp.mapping.preset.cmdline(), sources = { { name = "buffer" } } }
-- )
-- cmp.setup.cmdline(":", {
-- 	mapping = cmp.mapping.preset.cmdline(),
-- 	sources = cmp.config.sources({
-- 		{ name = "cmdline" },
-- 		{ name = "buffer", keyword_length = 3 },
-- 		{ name = "path" },
-- 		{ name = "zsh", trigger_characters = { ":!" } }, --- @see cmp-zsh
-- 	}),
-- })

require('nvim-autopairs').setup({ --- @see nvim-autopairs
	disable_filetype = { 'TelescopePrompt', 'vim' },
	check_ts = false,
})

-- completions
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:clear()
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({}))

local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')
local rules = npairs.config.rules
