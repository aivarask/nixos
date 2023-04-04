local complete_snippets = function()
  require('cmp').complete({ config = { sources = { { name = 'luasnip' } } } })
end
vim.keymap.set('i', '<C-b>', complete_snippets)
vim.keymap.set('n', 'qq', require('nvim-tree.api').tree.toggle)
vim.keymap.set({ 'n', 'i' }, '<F2>', vim.lsp.buf.hover, {desc='vim.lsp.buf.hover()'})
vim.keymap.set({ 'n', 'i' }, '<F3>', vim.lsp.buf.signature_help, {desc = 'vim.lsp.buf.signature_help()'})
-- vim.keymap.set({ 'n', 'i', 'v' }, '<F4>', function()
--   vim.cmd.help(vim.fn.expand('<cword>'))
-- end, {desc = 'vim.cmd.help(vim.fn.expand("<cword>"))'})

vim.keymap.set('n', '<leader>dw', require('diaglist').open_all_diagnostics)
vim.keymap.set('n', '<leader>d0', require('diaglist').open_buffer_diagnostics)
vim.keymap.set({ 'n' }, '<leader>li', '<cmd>LspInfo<CR>')
vim.keymap.set({ 'n' }, '<leader>lr', '<cmd>LspRestart<CR>')
vim.keymap.set({ 'n', 't', 'i' }, '<F12>', '<cmd>ToggleTerm direction=horizontal<CR>')
vim.keymap.set({ 'n', 't', 'i' }, '<F24>', '<cmd>ToggleTerm direction=vertical<CR>')
vim.keymap.set('n', '<leader>pr', [[:ProjectRoot<CR>]])


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

vim.keymap.set('n', '<leader><leader>ds', [[:DeleteSession<CR>]])
vim.keymap.set('n', '<leader>sr', [[:RestoreSession<CR>]])
vim.keymap.set('n', '<leader>ss', [[:SearchSession<CR>]])
vim.keymap.set('n', '<leader><leader>s', [[:SaveSession<CR>]])

function GoGithub()
  -- "github:nix-community/neovim-nightly-overlay";
  local pre = 'https://github.com/'
  local word = vim.fn.expand('<cWORD>')
  word = word:gsub('github:', pre)
  word = word:gsub(';', '')
  vim.cmd('!xdg-open ' .. word)
end
vim.keymap.set('n', '<leader>gg', GoGithub)

function GoHomepage(arg)
  vim.cmd([[!nix eval nixpkgs\#]]..arg..[[.meta.homepage | xargs xdg-open]])
end
vim.keymap.set('n', '<leader>gh', function ()
  GoHomepage(vim.fn.expand('<cword>'))
end, {desc = "meta.homepage"})
vim.keymap.set('n', '<leader>gH', function ()
  GoHomepage(vim.fn.expand('<cWORD>'))
end, {desc = "meta.homepage <cWORD>"})
-- zsh-nix-shell

vim.keymap.set('n','<leader>gmn', [[:exe '!xdg-open https://mynixos.com/search\?q=' .. expand('<cword>')<CR>]])
vim.keymap.set('n', '<leader><leader>p', [[:!xdg-open http://localhost:5173<CR>]])

function GoDocs(arg)
  -- "@typescript-eslint/eslint-plugin": "^5.54.1",
  -- import msw from 'msw',
  local pre = arg or '!npm docs '
  local pat1 = "'[^']*'"
  local pat2 = '"[^"]*"'
  local patts = {pat1, pat2}

  function goto(pat)
    local val = vim.fn.matchstr(vim.api.nvim_get_current_line(), pat)

    if not val or val == '' then
      print('Not found with pattern: ' .. pat)
    else
      print('Found with pattern: ' .. pat)
      vim.cmd(pre .. val)
      return 1
    end
  end

  for _, value in pairs(patts) do
    if (goto(value))
    then
      break
    end
  end
end
vim.keymap.set('n', '<leader>gd', GoDocs, { desc = 'npm docs <word>' })
vim.keymap.set('n', '<leader>gr', function ()
  GoDocs('!npm repo ')
end   , { desc = 'npm docs <word>' })

function Bc()
  local cword = vim.fn.expand('<cword>')
  local cWORD = vim.fn.expand('<cWORD>')
  local cexpr = vim.fn.expand('<cexpr>')
  local cfile = vim.fn.expand('<cfile>')
  -- '"\zs[^"]+\ze"'
  local mat = vim.fn.matchstr(vim.fn.line('.'), '"\v\zs[^"]+\ze"')
  local matchs = vim.fn.matchstr(vim.fn.line(''), '\v')
  print(vim.inspect({
    -- cword,
    -- cWORD,
    -- cexpr,
    -- cfile,
    mat,
    matchs,
  }))
end
