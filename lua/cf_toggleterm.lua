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

htop = T:new({ cmd = 'htop', hidden = true, direction = 'float' })
vim.keymap.set({ 'n', 't' }, '\\\\h', function() htop:toggle(nil, 'float') end, { desc = 'htop' })


nix_tree = T:new({ cmd = 'nix-tree', hidden = true, direction = 'float' })
vim.keymap.set({ 'n', 't' }, '\\\\t', function() nix_tree:toggle(nil, 'float') end, { desc = 'nix-tree' })

systemctl_tui = T:new({ cmd = 'systemctl-tui', hidden = true, direction = 'float' })
vim.keymap.set({ 'n', 't' }, '\\\\s', function() systemctl_tui:toggle(nil, 'float') end, { desc = 'systemctl-tui' })

lazygit = T:new({ cmd = 'lazygit', hidden = true, direction = 'float' })
vim.keymap.set({ 'n', 't' }, '\\\\l', function() lazygit:toggle(nil, 'float') end, { desc = 'lazygit' })

lf = T:new({ cmd = 'lf', hidden = true, direction = 'float' })
vim.keymap.set({ 'n', 't' }, '\\\\L.', function() lf:toggle(nil, 'float') end, { desc = 'lf .' })

lf_buf = T:new({ cmd = 'lf ' .. vim.fn.expand('%'), hidden = true, direction = 'float' })
vim.keymap.set({ 'n', 't' }, '\\\\L%',
	function() return T:new({ cmd = 'lf ' .. vim.fn.expand('%'), direction = 'float' }):open() end, { desc = 'lf %' })

man_fzf = T:new({ cmd = 'man_fzf', hidden = true, direction = 'float' })
vim.keymap.set({ 'n', 't' }, '\\\\m', function() man_fzf:toggle(nil, 'float') end, { desc = 'man_fzf' })

nix_repl_self = T:new({ cmd = 'nix repl self', hidden = true, direction = 'float' })
vim.keymap.set({ 'n', 't' }, '|3', function() nix_repl_self:toggle(nil, 'float') end, { desc = 'nix repl self' })
