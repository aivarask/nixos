-- https://github.com/akinsho/toggleterm.nvim#setup
require('toggleterm').setup({
  shade_terminals = false,
  size = function(term)
    if term.direction == 'horizontal' then
      return vim.o.lines * 0.2
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.3
    elseif term.direction == 'float' then
      return vim.o.columns * 0.6
    end
  end,
  -- open_mapping = [[<c-\>]],
  -- insert_mappings = true,
  float_opts = {
    height = 50,
  },
})

local Terminal = require('toggleterm.terminal').Terminal
local nix_repl = Terminal:new({ cmd = 'nix repl', hidden = true })

function _nix_repl_toggle() nix_repl:toggle() end
