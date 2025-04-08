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

empty = t:new({ cmd = '', hidden = true, direction = 'float' })
lf = t:new({ cmd = 'lf', hidden = true, direction = 'float' })
lg = t:new({ cmd = 'lazygit', hidden = true, direction = 'float' })
man = t:new({ cmd = 'fzf-man-widget', hidden = true, direction = 'float' })

local mode = { 'n', 't' }
require('which-key').add({
	{ '<C-\\>', '<cmd>ToggleTerm<CR>', mode = { 'n', 'i', 't' } },
	{ '`', '<cmd>ToggleTerm direction=horizontal<CR>', mode = { 'n', 't' } },
	{ '<C-`>', '<cmd>ToggleTerm direction=tab<CR>', mode = { 'n', 't' } },
	{ '|0', function() empty:toggle(nil, 'float') end, desc = 'empty', mode = mode },
	{ '|1', function() lf:toggle(nil, 'float') end, desc = 'lf', mode = mode },
	{ '|2', function() lg:toggle(nil, 'float') end, desc = 'lg', mode = mode },
	{ '|3', function() man:toggle(nil, 'float') end, desc = 'fzf-man-widget', mode = mode },
	{ '\\l', function() lg:toggle(nil, 'float') end, mode = mode },
})
