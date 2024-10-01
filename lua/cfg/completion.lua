local luasnip = require('luasnip') --- @see luasnip
require('luasnip.loaders.from_vscode').lazy_load() --- @see https://github.com/rafamadriz/friendly-snippets
require('luasnip.loaders.from_vscode').load({ paths = '/etc/nixos/snippets' })

-- require('copilot').setup({
--   suggestion = { enabled = false },
--   panel = { enabled = false },
-- })
local lspkind = require('lspkind')

local cmp = require('cmp') --- @see nvim-cmp
cmp.setup({
  enabled = function()
    return vim.api.nvim_get_option_value('buftype', { buf = 0 }) ~= 'prompt' or require('cmp_dap').is_dap_buffer()
  end,
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol',
      max_width = 50,
      show_labelDetails = true,
      symbol_map = { Copilot = '' },
    }),
  },

  sources = cmp.config.sources({
    -- { name = 'copilot', group_index = 2 },
    { name = 'nvim_lsp', group_index = 2 }, --- @see cmp-nvim-lsp
    { name = 'path', group_index = 2 }, --- @see cmp-path
    { name = 'luasnip', group_index = 2 },
    { name = 'emoji', group_index = 2 }, --- @see cmp-emoji
    -- { name = 'zsh' }, --- @see cmp-zsh
    -- { name = 'buffer' }, --- @see https://github.com/hrsh7th/cmp-buffer
  }),
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete({}),
    ['<C-z>'] = cmp.mapping.complete({ config = { sources = { { name = 'zsh' } } } }),
    ['<C-b>'] = cmp.mapping.complete({ config = { sources = { { name = 'luasnip' } } } }),
    ['<M-a>'] = cmp.mapping.abort(),
    ['<M-n>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { 'i', 's', 'c' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's', 'c' }),
  }),
})

cmp.setup.cmdline(
  { '/', '?' }, --- @see cmp-cmdline https://github.com/hrsh7th/cmp-cmdline
  { mapping = cmp.mapping.preset.cmdline(), sources = { { name = 'buffer' } } }
)
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'cmdline' },
    { name = 'buffer' },
    { name = 'path' },
  }),
})

require('nvim-autopairs').setup({ --- @see nvim-autopairs
  disable_filetype = { 'TelescopePrompt', 'vim' },
  check_ts = false,
})

-- completions
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:clear()
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({}))

npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')
local rules = npairs.config.rules
