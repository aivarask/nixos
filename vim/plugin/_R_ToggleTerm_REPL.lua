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
  open_mapping = [[<c-\>]],
  float_opts = {
    height = 50,
  },
})

local Terminal = require('toggleterm.terminal').Terminal
local nix_repl = Terminal:new({ cmd = 'nix repl', hidden = true })

function _nix_repl_toggle()
  nix_repl:toggle()
end

-- https://github.com/akinsho/toggleterm.nvim#custom-terminal-usage
-- https://discourse.nixos.org/t/nix-repl-add-builtins-to-global-scope/2678
-- https://nixos.wiki/wiki/Nix_command/repl
wkr({
  name = 'REPL',
  n = { '<cmd>lua _nix_repl_toggle()<CR>', '_nix_repl_toggle' },
  t = {
    function()
      Terminal:new({ cmd = 'nix repl' }):toggle()
    end,
    'nix repl test function',
  },
  f = {
    function()
      print(vim.fn.expand('%'))
      Terminal:new({ cmd = 'nix repl --file ' .. vim.fn.expand('%') }):toggle()
    end,
    'nix repl --file',
  },
}, { prefix = '<leader>R' })
