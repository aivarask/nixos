vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

persistence = require('persistence')
wkr = require('which-key').register
root_pattern = require('lspconfig.util').root_pattern
capabilities = require('cmp_nvim_lsp').default_capabilities()
flags = { debounce_text_changes = 150 }

-- https://github.com/neovim/nvim-lspconfig#suggested-configuration
on_attach = function(_, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '?', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
  vim.keymap.set({ 'n', 'v' }, ']f', vim.lsp.buf.code_action, bufopts)
end
-- https://github.com/antosha417/nvim-lsp-file-operations
require('lsp-file-operations').setup()

person = { name = 'Alice' }

-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Open-At-Startup#recipes
-- local function open_nvim_tree(data)
--   local real_file = vim.fn.filereadable(data.file) == 1
--   local no_name = data.file == '' and vim.bo[data.buf].buftype == ''
--   if not real_file and not no_name then
--     return
--   end
--   require('nvim-tree.api').tree.toggle({ focus = false, find_file = true })
-- end
-- vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = open_nvim_tree })

-- https://github.com/airblade/vim-gitgutter
-- https://github.com/lewis6991/gitsigns.nvim
-- require('gitsigns').setup({})
