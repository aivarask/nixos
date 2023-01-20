-- https://github.com/anuvyklack/pretty-fold.nvim
-- require('pretty-fold').setup()

-- https://github.com/akinsho/toggleterm.nvim#setup
require('toggleterm').setup({
  shade_terminals = false,
  size = function(term)
    if term.direction == 'horizontal' then
      return 30
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.4
    elseif term.direction == 'float' then
      return vim.o.columns * 0.6
    end
  end,
  float_opts = {
    height = 50,
  },
})

require('indent_blankline').setup({
  -- https://github.com/lukas-reineke/indent-blankline.nvim
  -- for example, context is off by default, use this to turn it on
  show_current_context = true,
  show_current_context_start = true,
})

require('symbols-outline').setup({})

require('nvim-web-devicons').setup()

-- https://github.com/norcalli/nvim-colorizer.lua
require('colorizer').setup({
  RGB = true, -- #RGB hex codes
  RRGGBB = true, -- #RRGGBB hex codes
  names = true, -- "Name" codes like Blue
  RRGGBBAA = false, -- #RRGGBBAA hex codes
  rgb_fn = false, -- CSS rgb() and rgba() functions
  hsl_fn = false, -- CSS hsl() and hsla() functions
  css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
  css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
  -- Available modes: foreground, background
  mode = 'background', -- Set the display mode.
})

-- https://github.com/edluffy/hologram.nvim
-- require("hologram").setup({ auto_display = true })

-- https://github.com/onsails/diaglist.nvim
require('diaglist').init({})

vim.keymap.set('n', '<C-u>', function()
  print(-vim.wo.scroll)
  require('neoscroll').scroll(-10, true, 200)
end)
-- https://github.com/karb94/neoscroll.nvim
require('neoscroll').setup()

-- https://github.com/onsails/lspkind.nvim
require('lspkind').init({
  mode = 'symbol_text',
  preset = 'codicons',
  symbol_map = {
    Text = '',
    Method = '',
    Function = '',
    Constructor = '',
    Field = 'ﰠ',
    Variable = '',
    Class = 'ﴯ',
    Interface = '',
    Module = '',
    Property = 'ﰠ',
    Unit = '塞',
    Value = '',
    Enum = '',
    Keyword = '',
    Snippet = '',
    Color = '',
    File = '',
    Reference = '',
    Folder = '',
    EnumMember = '',
    Constant = '',
    Struct = 'פּ',
    Event = '',
    Operator = '',
    TypeParameter = '',
    Emmet = '',
  },
})
