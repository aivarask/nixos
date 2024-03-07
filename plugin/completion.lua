local luasnip = require('luasnip') -- luasnip friendly-snippets

require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip.loaders.from_vscode').load({ paths = '/etc/nixos/snippets' })

local npairs = require('nvim-autopairs').setup() -- nvim-autopairs
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

local cmp = require('cmp') -- nvim-cmp
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

cmp.setup({
  snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-b>'] = cmp.mapping.complete({ config = { sources = { { name = 'luasnip' } } } }),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
    ['<Tab>'] = function(fallback) if cmp.visible() then cmp.select_next_item() else fallback() end end,
    ['<S-Tab>'] = function(fallback) if cmp.visible() then cmp.select_prev_item() else fallback() end end,
    ['<C-n>'] = cmp.mapping(function(fallback) if luasnip.jumpable(1) then luasnip.jump(1) else fallback() end end,
      { 'i', 's', 'c' }),
    ['<C-p>'] = cmp.mapping(function(fallback) if luasnip.jumpable(-1) then luasnip.jump(-1) else fallback() end end,
      { 'i', 's', 'c' }),
  }),
  sources = cmp.config.sources({
      { name = 'nvim_lsp' }, -- cmp-nvim-lsp
      { name = 'emoji' },    -- cmp-emoji
    },
    {
      { name = 'path' },   -- cmp-path
      { name = 'buffer' }, -- cmp-buffer
    }),
})
-- cmp-cmdline
cmp.setup.cmdline({ '/', '?' }, { mapping = cmp.mapping.preset.cmdline(), sources = { { name = 'buffer' } } })
cmp.setup.cmdline(':',
  { mapping = cmp.mapping.preset.cmdline(), sources = cmp.config.sources({ { name = 'path' }, { name = 'cmdline' } }) })
cmp.setup.filetype('gitcommit', { sources = cmp.config.sources({ { name = 'git' } }, { { name = 'buffer' } }) })
cmp.setup.filetype('gitcommit', { sources = cmp.config.sources({ { name = 'git' } }, { { name = 'buffer' } }) })
cmp.setup.filetype('gitcommit', { sources = cmp.config.sources({ { name = 'git' } }, { { name = 'buffer' } }) })
