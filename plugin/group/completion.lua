-- https://github.com/hrsh7th/nvim-cmp
local cmp = require('cmp')
-- https://github.com/L3MON4D3/LuaSnip
local luasnip = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip.loaders.from_vscode').load({ paths = '/etc/nixos/snippets' })

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

---@type cmp.ConfigSchema
cmp.setup({
  snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false, cmp.ConfirmBehavior.Replace }),
    ['<Tab>'] = function(fallback) if cmp.visible() then cmp.select_next_item() else fallback() end end,
    ['<S-Tab>'] = function(fallback) if cmp.visible() then cmp.select_prev_item() else fallback() end end,
    ['<C-n>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { 'i', 's', 'c' }),
    ['<C-p>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's', 'c' }),
  }),
  sources = cmp.config.sources({
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'emoji' },
  }, {
    { name = 'path' },
    { name = 'buffer' },
  }),
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = { { name = 'buffer' } },
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({ { name = 'path' }, { name = 'cmdline' } }),
})

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({ { name = 'git' } }, { { name = 'buffer' } }),
})
