local toggleterm = require('toggleterm')
toggleterm.setup({
	shade_terminals = false,
	size = function(term)
		return term.direction == 'horizontal' and vim.o.lines * 0.4
			or (term.direction == 'vertical' and vim.o.columns * 0.3)
	end,
	float_opts = {
		width = function() return math.ceil(vim.o.columns * 0.8) end,
		height = function() return math.ceil(vim.o.lines * 0.8) end,
	},
})

vim.api.nvim_create_autocmd('FileType', {
	group = vim.api.nvim_create_augroup('toggleterm', {}),
	pattern = 'toggleterm',
	desc = '<esc> <C-\\><C-n>',
	callback = function()
		local opts = { buffer = 0 }
		vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
	end,
})

local t = require('toggleterm.terminal').Terminal

lf = t:new({ cmd = 'lf', hidden = true, direction = 'float' })
htop = t:new({ cmd = 'htop', hidden = true, direction = 'float' })
nix_repl_self = t:new({ cmd = 'nix repl self', hidden = true, direction = 'float' })
ncmpcpp = t:new({ cmd = 'ncmpcpp', hidden = true, direction = 'float' })

local mode = { 'n', 't' }
require('which-key').add({
	{ '<C-\\>', '<cmd>ToggleTerm<CR>', mode = { 'n', 'i', 't' } },
	{ '`', '<cmd>ToggleTerm direction=horizontal<CR>', mode = { 'n', 't' } },
	{ '<C-`>', '<cmd>ToggleTerm direction=tab<CR>', mode = { 'n', 't' } },
	{ '<C-1>', function() nix_repl_self:toggle(nil, 'tab') end, mode = mode },
})
