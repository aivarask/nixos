-- https://github.com/charmbracelet/glamour
-- https://github.com/charmbracelet/glow
-- https://github.com/ellisonleao/glow.nvim
require('glow').setup({
  border = 'shadow', -- floating window border config
  style = 'dark',
  pager = false,
  width = 80,
  height = 100,
  width_ratio = 0.9, -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
  height_ratio = 0.9,
})
