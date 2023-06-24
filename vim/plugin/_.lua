wk = require('which-key')
wkr = require('which-key').register
tree = require('nvim-tree.api').tree
neotest = require('neotest')
dap = require('dap')
widgets = require('dap.ui.widgets')
osv = require('osv')
pretty = require('pl.pretty')

-- https://github.com/willothy/flatten.nvim
-- require('flatten').setup({
--   nest_if_no_args = true,
-- })

root_pattern = require('lspconfig.util').root_pattern
capabilities = require('cmp_nvim_lsp').default_capabilities()
-- https://github.com/neovim/nvim-lspconfig#suggested-configuration
on_attach = function(client, bufnr)
  vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = { '*.js', '*.ts' },
    callback = function(ctx)
      print('plugin/_.lua svelte lsp $/onDidChangeTsOrJsFile')
      if client.name == 'svelte' then
        client.notify('$/onDidChangeTsOrJsFile', { uri = ctx.file })
      end
    end,
  })

  -- https://github.com/Issafalcon/lsp-overloads.nvim
  -- if client.server_capabilities.signatureHelpProvider then
  --   require('lsp-overloads').setup(client, {
  --     keymaps = {
  --       next_signature = '<F7>',
  --       previous_signature = '<F6>',
  --       next_parameter = '<C-l>',
  --       previous_parameter = '<C-h>',
  --       close_signature = '<A-s>',
  --     },
  --   })
  -- end

  -- https://github.com/ray-x/lsp_signature.nvim
  local lsp_signature = require('lsp_signature')
  lsp_signature.on_attach({
    hint_enable = true,
    hint_prefix = '🚀 ',
    floating_window = false,
    -- floating_window_off_y = -1,
    -- floating_window_above_cur_line = false,
    close_timeout = 1000,
  }, bufnr)

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set({ 'i', 'n' }, '<F2>', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '?', require('fold-preview').toggle_preview, bufopts)
  vim.keymap.set({ 'i', 'n' }, '<F3>', lsp_signature.toggle_float_win, bufopts)
  vim.keymap.set({ 'n', 'v' }, ']f', vim.lsp.buf.code_action, bufopts)
end
flags = { debounce_text_changes = 150 }

-- https://github.com/antosha417/nvim-lsp-file-operations
require('lsp-file-operations').setup()

-- "github:nix-community/neovim-nightly-overlay";
function GoGithub()
  local pre = 'https://github.com/'
  local word = vim.fn.expand('<cWORD>')
  word = word:gsub('github:', pre)
  word = word:gsub(';', '')
  vim.cmd('!xdg-open ' .. word)
end

local complete_snippets = function()
  require('cmp').complete({ config = { sources = { { name = 'luasnip' } } } })
end
vim.keymap.set('i', '<C-b>', complete_snippets)
vim.keymap.set('n', 'qq', require('nvim-tree.api').tree.toggle)

vim.keymap.set({ 'n', 't', 'i' }, '<F12>', '<cmd>ToggleTerm direction=horizontal<CR>')
vim.keymap.set({ 'n', 't', 'i' }, '<F24>', '<cmd>ToggleTerm direction=vertical<CR>')

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'toggleterm',
  callback = set_terminal_keymaps,
})
