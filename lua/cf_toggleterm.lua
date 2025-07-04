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
	group = vim.api.nvim_create_augroup('toggleterm', { clear = true }),
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

T = require('toggleterm.terminal').Terminal
empty = T:new({ cmd = '', hidden = true, direction = 'float' })
vim.keymap.set({ 'n', 't' }, '`', '<cmd>ToggleTerm direction=horizontal<CR>')
systemctl_tui = T:new({ cmd = 'systemctl-tui', hidden = true, direction = 'float' })
vim.keymap.set({ 'n', 't' }, '\\S', function() systemctl_tui:toggle(nil, 'float') end,
	{ desc = 'systemctl-tui toggleterm' })
lazygit = T:new({ cmd = 'lazygit', hidden = true, direction = 'float' })
vim.keymap.set({ 'n', 't' }, '\\L', function() lazygit:toggle(nil, 'float') end, { desc = 'lazygit toggleterm' })
lf = T:new({ cmd = 'lf', hidden = true, direction = 'float' })
vim.keymap.set({ 'n', 't' }, '|ll', function() lf:toggle(nil, 'float') end, { desc = 'lf' })
lf_buf = T:new({ cmd = 'lf ' .. vim.fn.expand('%'), hidden = true, direction = 'float' })
vim.keymap.set({ 'n', 't' }, '|lb',
	function() return T:new({ cmd = 'lf ' .. vim.fn.expand('%'), direction = 'float' }):open() end, { desc = 'lf %' })
man_fzf = T:new({ cmd = 'man-fzf', hidden = true, direction = 'float' })
vim.keymap.set({ 'n', 't' }, '|2', function() man_fzf:toggle(nil, 'float') end, { desc = 'man-fzf' })
nix = T:new({ cmd = 'nix repl self', hidden = true, direction = 'float' })
vim.keymap.set({ 'n', 't' }, '|3', function() nix:toggle(nil, 'float') end, { desc = 'nix repl self' })

-- nix
vim.keymap.set({ 'n', 't' }, '|nt',
	function() return T:new({ cmd = 'nix-tree', direction = 'float' }):open() end, { desc = 'nix-tree' })
