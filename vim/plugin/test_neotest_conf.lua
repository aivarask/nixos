local neotest = require('neotest')

vim.keymap.set('n', '<leader>nrr', [[:lua require('neotest').run.run()<cr>]])
vim.keymap.set('n', '<leader>nra', [[require('neotest').run.attach()<cr>]])
vim.keymap.set('n', '<leader>nrl', [[:lua require('neotest').run.run_last()<cr>]])
vim.keymap.set('n', '<leader>nst', [[:lua require('neotest').summary.toggle()<cr>]])
vim.keymap.set('n', '<leader>nrs', [[:lua require('neotest').run.stop()<cr>]])
vim.keymap.set('n', '<leader>not', function()
  neotest.output_panel.toggle({ enter = true })
end)

vim.keymap.set('n', '<leader>n%', [[:lua require('neotest').run.run(vim.fn.expand('%')<cr>]])
vim.keymap.set('n', '<leader>nd', [[:lua require('neotest').run.run( {strategy = 'dap' })<cr>]])
vim.keymap.set({ 'n', 'i' }, '<F29>', [[:lua require('neotest').run.run({ suite = true })<cr>]])
vim.keymap.set({ 'n', 'i' }, '<F5>', [[:lua require('neotest').run.run()<cr>]])
vim.keymap.set({ 'n', 'i' }, '<F6>', [[:lua require('neotest').run.run(vim.fn.expand('%'))<cr>]])
vim.keymap.set({ 'n', 'i' }, '<F7>', [[:lua require('neotest').summary.toggle()<cr>]])
vim.keymap.set({ 'n', 'i' }, '<F8>', [[:lua require('neotest').output_panel.toggle()<cr>]])
vim.keymap.set({ 'n' }, '<leader>]', [[:lua require('neotest').summary.toggle()<cr>]])

-- https://github.com/nvim-neotest/neotest
require('neotest').setup({
  summary = {
    open = 'botright vsplit | vertical resize 40 | set winfixwidth',
  },
  quickfix = {
    enabled = true,
    open = false,
  },
  adapters = {
    -- https://github.com/nvim-neotest/neotest/blob/master/lua/neotest/config/init.lua#L131
    -- require('neotest-vitest'),

    require('neotest-playwright').adapter({}),
  },
})
