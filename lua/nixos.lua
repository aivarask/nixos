-- let &runtimepath.=',/etc/nixos'
vim.cmd [[
runtime! lua/*{.vim}
]]
vim.loader.enable()
uv = vim.uv
require 'cf_all'
require 'cf_diagnostic'
require 'cf_lsp'
require 'cf_lsp_attach'
-- require 'cf_lualine'
-- require 'cf_telescope'
