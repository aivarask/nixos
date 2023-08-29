wkr({
  ['<M-Tab>'] = { [[<cmd>tabnext<cr>]], 'tabnext', mode = { 'n', 'i', 't' } },
  ['<M-Del>'] = { [[<cmd>tabclose<cr>]], 'tabclose', mode = { 'n', 'i', 't' } },
  ['<C-b>'] = { cmp_complete_luasnip, 'cmp.complete.luasnip', mode = 'i' },
  K = { vim.lsp.buf.hover, 'vim.lsp.buf.hover' },
  qq = { require('nvim-tree.api').tree.toggle, 'nvim-tree.toggle' },
})

wkr({
  name = 'g',
  D = { vim.lsp.buf.declaration, 'vim.lsp.buf.declaration' },
  d = { vim.lsp.buf.definition, 'vim.lsp.buf.definition' },
  i = { vim.lsp.buf.implementation, 'vim.lsp.buf.implementation' },
  r = { vim.lsp.buf.references, 'vim.lsp.buf.references' },
  t = { vim.lsp.buf.type_definition, 'vim.lsp.buf.type_definition' },
  x = { [[\gx]], '!xdg-open <cfile>', noremap = false },
  q = {
    -- TODO: focus <cfile> in nvim-tree
    function()
      require('nvim-tree.api').tree.find_file({ 'modules/services/x11/redshift.nix', true })
    end,
    'nvim-tree.api.tree.find_file',
  },
}, { prefix = 'g' })

wkr({
  name = '1L',
  -- d = ./_dap_keys.lua
  -- g = ./_goto_keys.lua
  -- n = ./_neotest_keys.lua
  -- r = ./_rename.lua
  -- s = ./_session_config.lua
  -- t = ./_telescope_config.lua
  -- x = ./_x_trouble_config.lua
  -- y = ./_yank.lua
  ['='] = { sveltekit_file, 'sveltekit_file' },
  ['4'] = { [[:call ak#toggle_dollar()<CR>]], 'ak#toggle_dollar' },
  ['?'] = { wk.show, 'wk.show()' },
  [']'] = { neotest.summary.toggle, 'neotest.summary.toggle()' },
  S = { [[:'<,'>sort<CR>]], ':sort', noremap = false, mode = { 'v' } },
  a = { vim.lsp.buf.code_action, 'vim.lsp.buf.code_action', mode = { 'n', 'v' } },
  T = {
    name = 'Treesitter',
    i = { vim.treesitter.inspect_tree, 'vim.treesitter.inspect_tree' },
  },
  b = {
    name = 'Buffers',
    D = { [[:CloseRestBuffers]], 'CloseRestBuffers' },
  },
  l = {
    name = 'Lsp,LazyGit,Lf',
    i = { [[:LspInfo<CR>]], 'LspInfo' },
    l = { [[:LspLog<CR>]], 'LspLog' },
    r = { [[:LspRestart<CR>]], 'LspRestart' },
    g = { [[:LazyGit<CR>]], 'LazyGit' },
    f = { [[:LfCurrentDirectory<CR>]], 'LfCurrentDirectory' },
    t = { [[:LfNewTab<CR>]], 'LfNewTab' },
    w = { [[:LfWorkingDirectory<CR>]], 'LfWorkingDirectory' },
  },
  p = {
    name = 'Playwright',
    ---@diagnostic disable-next-line: undefined-field
    a = { neotest.playwright.attachment, 'playwright.attachment' },
    p = { [[:NeotestPlaywrightPreset<CR>]], 'PlaywrightPreset' },
    r = { [[:NeotestPlaywrightRefresh<CR>]], 'PlaywrightRefresh' },
  },
}, { prefix = '<leader>' })
