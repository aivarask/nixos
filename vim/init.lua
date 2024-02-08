vim.cmd([[
  let &runtimepath.=',/etc/nixos'
  source /etc/nixos/vimrc.vim
]])

vim.loader.enable()

function LspLogClear()
  io.popen('echo > ' .. vim.lsp.get_log_path())
  vim.lsp.set_log_level(vim.lsp.log_levels.WARN)
end

LspLogClear()

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'toggleterm',
  callback = function()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<cmd>wincmd l<CR>]], opts)
  end,
})

neotest = require('neotest')

dap = require('dap')
widgets = require('dap.ui.widgets')
dapui = require('dapui')
