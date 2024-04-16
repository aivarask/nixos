-- toggleterm-nvim
require('toggleterm').setup({
  shade_terminals = false,
  size = function(term)
    if term.direction == 'horizontal' then
      return vim.o.lines * 0.4
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.3
    end
  end,
  -- open_mapping = [[<c-\>]],
  -- insert_mappings = true,
  float_opts = {
    width = function() return math.ceil(vim.o.columns * 0.8) end,
    height = function() return math.ceil(vim.o.lines * 0.8) end,
  },
})

local Terminal = require('toggleterm.terminal').Terminal
local nix_repl = Terminal:new({ cmd = 'nix repl', hidden = true })

function _nix_repl_toggle() nix_repl:toggle() end

require('which-key').register({
  -- ['<c-\>'] = {},
  r = { _nix_repl_toggle, 'nix repl' },
}, { prefix = [[<c-\>]] })

require('which-key').register({
  -- ['<F11>'] = { "<cmd>ToggleTerm direction=float <CR>", 'ToggleTerm direction=float', mode = { 'n', 'i', 't' } },
  -- ['<F23>'] = { "<cmd>exec 'ToggleTerm direction=vertical dir=' .. expand('%:p:h')<CR>", 'ToggleTerm relative vertical', mode = { 'n', 'i', 't' } },
  -- ['<F35>'] = { "<cmd>exec 'ToggleTerm direction=tab dir=' .. expand('%:p:h')<CR>", 'ToggleTerm relative tab', mode = { 'n', 'i', 't' } },
  ['`'] = { '<F12>', '', noremap = false },
  ['<F12>'] = { '<cmd>ToggleTerm direction=horizontal<CR>', 'ToggleTerm horizontal', mode = { 'n', 'i', 't' } },
  ['<F24>'] = { '<cmd>ToggleTerm direction=vertical<CR>', 'ToggleTerm', mode = { 'n', 'i', 't' } },
  ['<F36>'] = { '<cmd>ToggleTerm direction=tab<CR>', 'ToggleTerm', mode = { 'n', 'i', 't' } },
})

vim.api.nvim_create_augroup('ToggleTermKeymaps', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = 'ToggleTermKeymaps',
  desc = 'keymap.set on filetype toggleterm',
  pattern = 'toggleterm',
  callback = function()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<cmd>wincmd l<CR>]], opts)
    vim.keymap.set('t', '<F11>', [[<cmd>LazyGit<CR>]], opts)
  end,
})
