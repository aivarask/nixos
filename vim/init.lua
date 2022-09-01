vim.cmd([[
source /etc/nixos/vim/vimrc.vim
]])

-- require("debug.init")
require("ui")
require("treesitter")
require("misc")
require("completion")

-- require("lsp.cssls")
-- require("lsp.stylelint")
-- require("lsp.python")
require("lsp.bashls")
-- require("lsp.clangd")

require("lsp.emmet-ls")
require("lsp.json")
-- require("lsp.php")
require("lsp.prismals")
require("lsp.rnix")
require("lsp.sumneko")
require("lsp.svelte")
require("lsp.tailwind")
require("lsp.tsserver")
-- require("lsp.vimls")
require("lsp.null-ls")
