local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end
local luasnip = require('luasnip')
luasnip.filetype_extend('typescript', { 'javascript' })
require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip.loaders.from_vscode').load({ paths = '/etc/nixos/vim/snippets' })

local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  -- https://github.com/onsails/lspkind.nvim
  formatting = {
    format = require('lspkind').cmp_format({
      mode = 'symbol_text',
      maxwidth = 80,
    }),
  },
  preselect = cmp.PreselectMode.None,
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<PageUp>'] = cmp.mapping.scroll_docs(-4),
    ['<PageDown>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete({}), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping(cmp.mapping.abort(), { 'i', 'c' }),
    ['<C-b>'] = cmp.mapping.complete({
      config = {
        sources = {
          { name = 'luasnip' },
        },
      },
    }),
    ['<CR>'] = cmp.mapping(
      cmp.mapping.confirm({
        select = false,
        behavior = cmp.ConfirmBehavior.Replace,
      }),
      { 'i', 'c' }
    ),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's', 'c' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's', 'c' }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    -- {
    --   name = 'luasnip',
    --   -- https://github.com/saadparwaiz1/cmp_luasnip
    --   option = { show_autosnippets = false, use_show_condition = false },
    -- },
    { name = 'path' }, -- https://github.com/hrsh7th/cmp-path
    -- {
    --   name = 'buffer',
    --   option = {
    --     get_bufnrs = function()
    --       return vim.api.nvim_list_bufs()
    --     end,
    --   },
    -- },
    { name = 'emoji' },
    -- https://github.com/hrsh7th/cmp-nvim-lsp-signature-help
    -- { name = 'nvim_lsp_signature_help' },
    -- { name = 'treesitter' },
    -- { name = 'npm', keyword_length = 4 },
  }),
})

-- https://github.com/hrsh7th/cmp-cmdline
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    {
      name = 'buffer',
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    },
  },
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path', option = { trailing_slash = false } },
    { name = 'zsh' },
  }, {
    {
      name = 'cmdline',
      option = {
        ignore_cmds = {
          'Man',
          -- '!'
        },
      },
    },
  }),
})

-- https://github.com/windwp/nvim-autopairs
local npairs = require('nvim-autopairs')
-- FastWrap
npairs.setup({
  fast_wrap = {
    map = '<M-e>',
    chars = { '{', '[', '(', '"', "'", '<' },
    pattern = [=[[%'%"%)%>%]%)%}%,]]=],
    end_key = '$',
    keys = 'qwertyuiopzxcvbnmasdfghjkl',
    check_comma = true,
    highlight = 'Search',
    highlight_grey = 'Comment',
  },
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
