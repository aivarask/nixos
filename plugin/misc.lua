-- outline.nvim
-- @alternative aerial-nvim
require 'outline'.setup {}

-- flatten.nvim flatten-nvim
-- require("flatten").setup({ nest_if_no_args = true })

-- glow.nvim glow-nvim
-- require 'glow'.setup {
--   width = 80,
--   height = 100,
--   width_ratio = 0.9,
--   height_ratio = 0.9,
-- }

-- require('neoscroll').setup({ -- neoscroll-nvim
--   respect_scrolloff = true,
-- })
-- vim.cmd [[
  -- set scrolloff=6
-- ]]

require 'dressing'.setup {}          -- dressing-nvim
require 'colorizer'.setup {}         -- colorizer-nvim
require 'nvim-web-devicons'.setup {} -- nvim-dev-icons

if vim.uv.os_getenv 'DISPLAY' then
  require "image".setup {
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
    editor_only_render_when_focused = true,                                   -- auto show/hide images when the editor gains/looses focus
    tmux_show_only_in_active_window = false,                                  -- auto show/hide images in the correct Tmux window (needs visual-activity off)
    hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
  }
end
