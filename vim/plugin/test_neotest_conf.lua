local neotest = require('neotest')

-- https://github.com/nvim-neotest/neotest
require('neotest').setup({
  output_panel = {
    enabled = true,
    open = 'botright vsplit | vertical resize 60 | set winfixwidth',
  },
  summary = {
    open = 'botright vsplit | vertical resize 40 | set winfixwidth',
  },
  quickfix = {
    enabled = true,
    open = false,
  },
  adapters = {
    -- https://github.com/nvim-neotest/neotest/blob/master/lua/neotest/config/init.lua#L131
    require('neotest-vitest'),

    require('neotest-playwright').adapter({}),
  },
})

neotest.run.buffer = function()
  neotest.run.run(vim.fn.expand('%'))
end

neotest.run.suite = function()
  neotest.run.run({ suite = true })
end

neotest.run.greet = function()
  print('Hello neotest')
end

vim.keymap.set('n', '<leader>nrr', [[:lua require('neotest').run.run()<cr>]])
vim.keymap.set('n', '<leader>nra', [[require('neotest').run.attach()<cr>]])
vim.keymap.set('n', '<leader>nrl', [[:lua require('neotest').run.run_last()<cr>]])
vim.keymap.set('n', '<leader>nst', [[:lua require('neotest').summary.toggle()<cr>]])
vim.keymap.set('n', '<leader>nrs', [[:lua require('neotest').run.stop()<cr>]])

vim.keymap.set('n', '<leader>nd', [[:lua require('neotest').run.run( {strategy = 'dap' })<cr>]])
vim.keymap.set({ 'n', 'i' }, '<F5>', neotest.run.run)
vim.keymap.set({ 'n', 'i' }, '<F17>', neotest.run.greet)
vim.keymap.set({ 'n', 'i' }, '<F29>', neotest.run.suite)
vim.keymap.set({ 'n', 'i' }, '<F6>', neotest.run.buffer)
vim.keymap.set({ 'n', 'i' }, '<F7>', neotest.summary.toggle)
vim.keymap.set({ 'n', 'i' }, '<F8>', neotest.output_panel.toggle)
vim.keymap.set({ 'n', 'i' }, '<F20>', function()
  neotest.output_panel.open({ enter = true })
end)
--  require("neotest").output.open({ enter = true })
vim.keymap.set({ 'n' }, '<leader>]', [[:lua require('neotest').summary.toggle()<cr>]])
