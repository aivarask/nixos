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

Terminal = require('toggleterm.terminal').Terminal

empty = Terminal:new({ cmd = '', hidden = true, direction = 'float' })
vim.keymap.set({ 'n', 't' }, '`', '<cmd>ToggleTerm direction=horizontal<CR>')

nix_tree = Terminal:new({ cmd = 'nix-tree', hidden = true, direction = 'float' })
vim.keymap.set({ 'n', 't' }, '\\\\t',
    function() nix_tree:toggle(nil, 'float') end, { desc = 'nix-tree' })

systemctl_tui = Terminal:new({ cmd = 'systemctl-tui', hidden = true, direction = 'float' })
vim.keymap.set({ 'n', 't' }, '\\\\s', function() systemctl_tui:toggle(nil, 'float') end, { desc = 'systemctl-tui' })

lazygit = Terminal:new({ cmd = 'lazygit', hidden = true, direction = 'float' })
vim.keymap.set({ 'n', 't' }, '\\\\l', function() lazygit:toggle(nil, 'float') end, { desc = 'lazygit' })

lf = Terminal:new({ cmd = 'lf', hidden = true, direction = 'float' })
vim.keymap.set({ 'n', 't' }, '\\\\.', function() lf:toggle(nil, 'float') end, { desc = 'lf .' })

lf_buf = Terminal:new({ cmd = 'lf ' .. vim.fn.expand('%'), hidden = true, direction = 'float' })
vim.keymap.set({ 'n', 't' }, '\\\\%',
    function() return Terminal:new({ cmd = 'lf ' .. vim.fn.expand('%'), direction = 'float' }):open() end,
    { desc = 'lf %' })
