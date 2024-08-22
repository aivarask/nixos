local luasnip = require 'luasnip'                 --- @see luasnip

require 'luasnip.loaders.from_vscode'.lazy_load() --- @see https://github.com/rafamadriz/friendly-snippets
require 'luasnip.loaders.from_vscode'.load { paths = '/etc/nixos/snippets', }


require 'nvim-autopairs'.setup { --- @see nvim-autopairs
  fast_wrap = {
    map = '<M-w>',
  },
}
local cmp_autopairs = require 'nvim-autopairs.completion.cmp'

local cmp = require 'cmp' --- @see nvim-cmp
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())


cmp.setup {
  snippet = { expand = function(args) luasnip.lsp_expand(args.body) end, },
  mapping = cmp.mapping.preset.insert {
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-b>'] = cmp.mapping.complete { config = { sources = { { name = 'luasnip', }, }, }, },
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm { select = true, behavior = cmp.ConfirmBehavior.Replace, },
    ['<Tab>'] = function(fallback) if cmp.visible() then cmp.select_next_item() else fallback() end end,
    ['<S-Tab>'] = function(fallback) if cmp.visible() then cmp.select_prev_item() else fallback() end end,
    ['<C-n>'] = cmp.mapping(function(fallback) if luasnip.jumpable(1) then luasnip.jump(1) else fallback() end end,
      { 'i', 's', 'c', }),
    ['<C-p>'] = cmp.mapping(function(fallback) if luasnip.jumpable(-1) then luasnip.jump(-1) else fallback() end end,
      { 'i', 's', 'c', }),
  },
  sources = cmp.config.sources({
      { name = 'nvim_lsp', }, --- @see cmp-nvim-lsp
      { name = 'emoji', },   --- @see cmp-emoji https://github.com/hrsh7th/cmp-emoji
    },
    {
      { name = 'path', },  --- @see cmp-path https://github.com/hrsh7th/cmp-path

      { name = 'buffer', }, --- @see cmp-buffer https://github.com/hrsh7th/cmp-buffer
    }),
  enabled = function()
    return vim.api.nvim_get_option_value("buftype", { buf = 0, }) ~= "prompt"
        or require "cmp_dap".is_dap_buffer()
  end,
}

cmp.setup.cmdline({ '/', '?', }, --- @see cmp-cmdline https://github.com/hrsh7th/cmp-cmdline
  { mapping = cmp.mapping.preset.cmdline(), sources = { { name = 'buffer', }, }, })
cmp.setup.cmdline(':',
  {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources {
      { name = 'cmdline', },
      { name = 'buffer', },
      { name = 'path', },
    },
  })

-- require("cmp").setup({
--   enabled = function()
--     return vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "prompt"
--         or require("cmp_dap").is_dap_buffer()
--   end,
-- })
cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover", }, {
  sources = {
    { name = "dap", },
  },
})
