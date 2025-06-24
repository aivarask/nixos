local toggleterm = require('toggleterm')
toggleterm.setup({
	shade_terminals = false,
	size = function(term)
		return term.direction == 'horizontal' and vim.o.lines * 0.4
				or (term.direction == 'vertical' and vim.o.columns * 0.3)
	end,
	float_opts = {
		width = function() return math.ceil(vim.o.columns * 0.9) end,
		height = function() return math.ceil(vim.o.lines * 0.9) end,
	},
})

vim.api.nvim_create_autocmd({
	-- 'FileType',
	'TermOpen'
}, {
	group = vim.api.nvim_create_augroup('toggleterm', {}),
	pattern = 'term://*',
	-- pattern = 'toggleterm',
	desc = '<esc> <C-\\><C-n>',
	callback = function(args)
		local file_match = args.match or args.file
		if not string.find(file_match, 'lazygit') then
			vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], { buffer = 0 })
		end
	end,
})

local T = require('toggleterm.terminal').Terminal
empty = T:new({ cmd = '', hidden = true, direction = 'float' })
vim.keymap.set({ 'n', 't' }, '`', '<cmd>ToggleTerm direction=horizontal<CR>')
lazygit = T:new({ cmd = 'lazygit', hidden = true, direction = 'float' })
vim.keymap.set({ 'n', 't' }, '\\L', function() lazygit:toggle(nil, 'float') end, { desc = 'lazygit toggleterm' })
lf = T:new({ cmd = 'lf', hidden = true, direction = 'float' })
vim.keymap.set({ 'n', 't' }, '|1', function() lf:toggle(nil, 'float') end, { desc = 'lf' })
man_fzf = T:new({ cmd = 'man-fzf', hidden = true, direction = 'float' })
vim.keymap.set({ 'n', 't' }, '|2', function() man_fzf:toggle(nil, 'float') end, { desc = 'man-fzf' })
nix = T:new({ cmd = 'nix repl self', hidden = true, direction = 'float' })
vim.keymap.set({ 'n', 't' }, '|3', function() nix:toggle(nil, 'float') end, { desc = 'nix repl self' })
