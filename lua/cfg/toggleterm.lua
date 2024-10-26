local toggleterm = require('toggleterm')
toggleterm.setup({
	shade_terminals = false,
	size = function(term)
		return term.direction == 'horizontal' and vim.o.lines * 0.4
			or (term.direction == 'vertical' and vim.o.columns * 0.3)
	end,
	float_opts = {
		width = function()
			return math.ceil(vim.o.columns * 0.8)
		end,
		height = function()
			return math.ceil(vim.o.lines * 0.8)
		end,
	},
})

require('which-key').add({
	{ '<C-\\>', '<cmd>ToggleTerm<CR>', mode = { 'n', 'i', 't' } },
	{ '`', '<cmd>ToggleTerm<CR>', mode = { 'n', 't' } },
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

local Terminal = require('toggleterm.terminal').Terminal
local lf = Terminal:new({ cmd = 'lf', hidden = true, direction = 'vertical' })
function _lf_toggle()
	lf:toggle()
end

vim.api.nvim_set_keymap('n', '<leader>j', '<cmd>lua _lf_toggle()<CR>', { noremap = true, silent = true })
