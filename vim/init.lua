vim.cmd([[
  let &runtimepath.=',/etc/nixos'
  source /etc/nixos/vim/vimrc.vim
]])

vim.loader.enable()
require('which-key').setup({})
wkr = require('which-key').register

function LspLogClear()
  io.popen('echo > ' .. vim.lsp.get_log_path())
  vim.lsp.set_log_level(vim.lsp.log_levels.WARN)
end

LspLogClear()
