wkr({
  name = '1L',
  -- d = ./_dap_keys.lua
  -- g = ./_goto_keys.lua
  -- n = ./_neotest_keys.lua
  -- r = ./_rename.lua
  -- s = ./_session_config.lua
  -- t = ./_telescope_config.lua
  -- x = ./_x_trouble_config.lua
  [']'] = { [[:SymbolsOutline<CR>]], 'SymbolsOutline' },

  S = { [[:'<,'>sort<CR>]], ':sort', noremap = false, mode = { 'v' } },
  T = {
    name = 'Treesitter',
    i = { vim.treesitter.inspect_tree, 'vim.treesitter.inspect_tree' },
  },
}, { prefix = '<leader>' })

wkr({
  ['<M-Tab>'] = { [[<cmd>tabnext<cr>]], 'tabnext', mode = { 'n', 'i', 't' } },
  ['<M-Del>'] = { [[<cmd>tabclose<cr>]], 'tabclose', mode = { 'n', 'i', 't' } },
  qq = { require('nvim-tree.api').tree.toggle, 'nvim-tree.toggle' },
})
