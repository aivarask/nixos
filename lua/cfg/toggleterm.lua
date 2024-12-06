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

lf = Terminal:new({ cmd = 'lf', display_name = 'lf toggleterm', hidden = true, direction = 'float' })
vim.api.nvim_set_keymap('n', '<leader>1', '<cmd>lua lf:toggle()<CR>', { noremap = true, silent = true })

nix_repl = Terminal:new({ cmd = 'nix repl', hidden = true, direction = 'tab' })
vim.api.nvim_set_keymap('n', '<leader>2', '<cmd>lua nix_repl:toggle()<CR>', { noremap = true, silent = true })

ncmpcpp = Terminal:new({ cmd = 'ncmpcppcxz< ', hidden = true, direction = 'float' })
vim.api.nvim_set_keymap('n', '<leader>3', '<cmd>lua ncmpcpp:toggle()<CR>', { noremap = true, silent = true })

-- vim.api.nvim_set_keymap('n', '<leader>4', function()
-- 	Terminal:new({ direction = 'tab' })
-- end, { noremap = true, silent = true })
