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
  ['}'] = { [[:SymbolsOutline<CR>]], 'SymbolsOutline' },

  S = { [[:'<,'>sort<CR>]], ':sort', noremap = false, mode = { 'v' } },
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
