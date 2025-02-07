-- vim:fdl=4

--- @doc https://github.com/rafamadriz/friendly-snippets
local luasnip = require('luasnip') --- @see luasnip
-- require('luasnip').filetype_extend('twig', { 'html' })
-- require('luasnip').filetype_extend('html', { 'twig' })
require('luasnip.loaders.from_vscode').lazy_load({ exclude = { 'all' } })
require('luasnip.loaders.from_vscode').load({ paths = '/etc/nixos/vim/snippets' })

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

require('smart_semicolon').setup()
local cmp = require('cmp') --- @see nvim-cmp
--- @type cmp.ConfigSchema
local config = {
	preselect = 'item',
	confirmation = {
		default_behavior = 'replace',
		get_commit_characters = function(commit_characters)
			return commit_characters
		end,
	},
	view = { docs = { auto_open = true } },
	experimental = { ghost_text = true },
	mapping = {
		['<C-e>'] = cmp.mapping.abort(),
		['<C-y>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.confirm({
					select = true,
				})
			else
				fallback()
			end
		end),
		['<C-l>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				return cmp.complete_common_string()
			end
			fallback()
		end, { 'i', 'c' }),
		['<C-u>'] = cmp.mapping.scroll_docs(-4),
		['<C-d>'] = cmp.mapping.scroll_docs(4),
		['<C-s>'] = cmp.mapping.complete({ config = { sources = cmp.config.sources({ { name = 'luasnip' } }) } }),

		['<C-n>'] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
			else
				cmp.complete()
			end
		end,
		['<C-p>'] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
			else
				fallback()
				-- cmp.complete()
			end
		end,
		['<Tab>'] = cmp.mapping(function(fallback)
			if luasnip and luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if luasnip and luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	},

	['snippet.expand'] = function(args)
		luasnip.lsp_expand(args.body)
	end,

	-- cmp-nvim-lsp cmp-path
	-- https://github.com/hrsh7th/cmp-buffer
	sources = cmp.config.sources({
		{
			name = 'nvim_lsp',
			entry_filter = function(entry, ctx)
				return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Keyword'
			end,
		},
		{ name = 'nvim_lsp_signature_help' },
	}, {
		-- { name = 'luasnip' },
		{ name = 'path' },
		-- { name = 'emoji'},
		-- { name = 'buffer' },
	}),
}
cmp.setup(config)

-- cmp.setup.cmdline(
-- 	'/', --- @see cmp-cmdline https://github.com/hrsh7th/cmp-cmdline
-- 	{
-- 		mapping = cmp.mapping.preset.cmdline(),
-- 		sources = cmp.config.sources(
-- 			-- { { name = 'nvim_lsp_document_symbol' } },
-- 			{ { name = 'buffer' } }
-- 		),
-- 	}
-- )
-- cmp.setup.cmdline(':', {
-- 	mapping = cmp.mapping.preset.cmdline(),
-- 	sources = cmp.config.sources({
-- 		{ name = 'buffer', keyword_length = 3 },
-- 		{ name = 'path' },
-- 		{ name = 'zsh', trigger_characters = { ':!' } }, --- @see cmp-zsh
-- 	}, {
-- 		{ name = 'cmdline' },
-- 	}),
-- })
-- cmp.setup.cmdline(':!', {
-- 	mapping = cmp.mapping.preset.cmdline(),
-- 	sources = cmp.config.sources(
-- 		--- @see cmp-zsh
-- 		-- {		{ name = 'zsh', trigger_characters = { ':!' } }	},
-- 		-- { { name = 'cmdline' } }
-- 	),
-- })

require('nvim-autopairs').setup({ --- @see nvim-autopairs
	disable_filetype = { 'TelescopePrompt', 'vim' },
	check_ts = false,
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:clear()
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({}))

local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')
local rules = npairs.config.rules
