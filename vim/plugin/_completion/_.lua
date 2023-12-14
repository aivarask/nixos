-- https://github.com/hrsh7th/nvim-cmp
local cmp = require('cmp')
-- https://github.com/L3MON4D3/LuaSnip
local luasnip = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip.loaders.from_vscode').load({
  paths = '/etc/nixos/vim/snippets',
})

wkr({
  name = 'Completion',
  e = {
    function()
      cmp.complete({ config = { sources = { name = 'emoji' } } })
    end,
    'emoji',
  },
}, { prefix = '<Space>i' })

---@type cmp.ConfigSchema
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({
      select = false,
      cmp.ConfirmBehavior.Replace,
    }),
    -- ['<CR>'] = cmp.mapping({
    --   -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#safely-select-entries-with-cr
    --   i = function(fallback)
    --     if cmp.visible() and cmp.get_active_entry() then
    --       cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
    --     else
    --       fallback()
    --     end
    --   end,
    --   s = cmp.mapping.confirm({ select = true }),
    --   c = cmp.mapping.confirm({
    --     behavior = cmp.ConfirmBehavior.Replace,
    --     select = true,
    --   }),
    -- }),
    -- ['<C-b>'] = cmp.mapping.confirm({
    --   cmp.ConfirmBehavior.Insert,
    --   select = true,
    -- }),

    -- ['<C-b>'] = cmp.mapping.complete({
    --   config = {
    --     sources = {
    --       { name = 'luasnip' },
    --     },
    --   },
    -- }),

    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
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
    -- { name = 'luasnip' },
    -- { name = 'buffer' },
  }),
})

-- Set configuration for specific filetype.
-- cmp.setup.filetype('gitcommit', {
--   sources = cmp.config.sources({
--     { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
--   }, {
--     { name = 'buffer' },
--   }),
-- })

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  },
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
  }),
})
