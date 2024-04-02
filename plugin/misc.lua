-- aerial-nvim
require("aerial").setup({
  on_attach = function(bufnr)
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
})

-- symbols-outline-nvim
require('symbols-outline').setup({
  auto_preview = false,
  autofold_depth = 1,
  position = "left",
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

-- require('neoscroll').setup({ -- neoscroll-nvim
--   respect_scrolloff = true,
-- })
vim.cmd([[
  set scrolloff=8
]])

require('dressing').setup({})          -- dressing-nvim
require('colorizer').setup({})         -- colorizer-nvim
require('nvim-web-devicons').setup({}) -- nvim-dev-icons

if vim.uv.os_getenv('DISPLAY') then
  require("image").setup({
    -- backend = "kitty",
    backend = "ueberzug",
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = false,
        filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
      },
      neorg = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = false,
        filetypes = { "norg" },
      },
    },
    max_width = nil,
    max_height = nil,
    max_width_window_percentage = nil,
    max_height_window_percentage = 50,
    window_overlap_clear_enabled = false,                                     -- toggles images when windows are overlapped
    window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    editor_only_render_when_focused = false,                                  -- auto show/hide images when the editor gains/looses focus
    tmux_show_only_in_active_window = false,                                  -- auto show/hide images in the correct Tmux window (needs visual-activity off)
    hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
  })
end
