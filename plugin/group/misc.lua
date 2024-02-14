vim.keymap.set('n', '<leader>]', [[:SymbolsOutline<CR>]])
-- symbols-outline-nvim
require('symbols-outline').setup({
  auto_preview = false,
  autofold_depth = 2,
  lsp_blacklist = { 'null-ls' },
  symbols = {
    File = { icon = "", hl = "@text.uri" },
    Module = { icon = "", hl = "@namespace" },
    Namespace = { icon = "", hl = "@namespace" },
    Package = { icon = "", hl = "@namespace" },
    Class = { icon = "", hl = "@type" },
    Method = { icon = "ƒ", hl = "@method" },
    Property = { icon = "", hl = "@method" },
    Field = { icon = "", hl = "@field" },
    Constructor = { icon = "", hl = "@constructor" },
    Enum = { icon = "", hl = "@type" },
    Interface = { icon = "", hl = "@type" },
    Function = { icon = "", hl = "@function" },
    Variable = { icon = "", hl = "@constant" },
    Constant = { icon = "", hl = "@constant" },
    String = { icon = "", hl = "@string" },
    Number = { icon = "#", hl = "@number" },
    Boolean = { icon = "", hl = "@boolean" },
    Array = { icon = "", hl = "@constant" },
    Object = { icon = "", hl = "@type" },
    Key = { icon = "", hl = "@type" },
    Null = { icon = "", hl = "@type" },
    EnumMember = { icon = "", hl = "@field" },
    Struct = { icon = "", hl = "@type" },
    Event = { icon = "", hl = "@type" },
    Operator = { icon = "", hl = "@operator" },
    TypeParameter = { icon = "", hl = "@parameter" },
    Component = { icon = "", hl = "@function" },
    Fragment = { icon = "", hl = "@constant" },
  },
})

-- flatten.nvim flatten-nvim
require("flatten").setup({})

-- glow.nvim glow-nvim
require('glow').setup({
  width = 80,
  height = 100,
  width_ratio = 0.9,
  height_ratio = 0.9,
})

require('neoscroll').setup({ -- neoscroll-nvim
  respect_scrolloff = true,
})
vim.cmd([[
  set scrolloff=8
]])

require('dressing').setup({})          -- dressing-nvim
require('colorizer').setup({})         -- colorizer-nvim
require('nvim-web-devicons').setup({}) -- nvim-dev-icons
