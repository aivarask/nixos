wkr({
  -- ['?'] = { require('fold-preview').toggle_preview, 'fold-preview.toggle_preview' },
  ['?'] = { vim.lsp.util.open_floating_preview, 'open_floating_preview' },
  K = { vim.lsp.buf.hover, 'vim.lsp.buf.hover' },
  qq = { require('nvim-tree.api').tree.toggle, 'nvim-tree.toggle' },
  ['<C-b>'] = { cmp_complete_luasnip, 'cmp.complete.luasnip', mode = 'i' },
  -- vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, bufopts)
})

wkr({
  name = '1L',
  ['?'] = { wk.show, 'wk.show()' },
  [']'] = { neotest.summary.toggle, 'neotest.summary.toggle()' },
  a = { vim.lsp.buf.code_action, 'vim.lsp.buf.conde_action', mode = { 'n', 'v' } },
  li = { '<cmd>LspInfo<cr>', 'LspInfo' },
  lr = { '<cmd>LspRestart<cr>', 'LspRestart' },
  it = { vim.treesitter.inspect_tree, 'vim.treesitter.inspect_tree' },
}, { prefix = '<leader>' })

wkr({
  name = '2L',
  [']'] = { neotest.output_panel.toggle, 'neotest.output_panel.toggle' },
}, { prefix = '<leader><leader>' })

wkr({
  name = '3L',
  [']'] = { '<cmd>SymbolsOutline<cr>' },
  ['1'] = { '<cmd>e languages/en.yml<cr>' },
  ['2'] = { '<cmd>e languages/lt.yml<cr>' },
  ['8'] = { '<cmd>e src/app.d.ts<cr>' },
  ['9'] = { '<cmd>e src/app.postcss<cr>' },
  ['p'] = { '<cmd>e package.json<cr>' },
  --
}, { prefix = '<leader><leader><leader>' })

wkr({
  name = '=',
  ['='] = { sveltekit_file, 'sveltekit_file' },
}, { prefix = '<leader>=' })

wkr({
  ['<S-Tab>'] = { '<cmd>bn<CR>', 'bn', mode = { 'i' } },
  ['<F1>'] = { help_cword, 'help_cword' },
  ['<F13>'] = { help_cWORD, 'help_cWORD' },
  ['<F25>'] = { help_cexpr, 'help_cexpr' },
  ['<F2>'] = { vim.lsp.buf.hover, 'vim.lsp.buf.hover', mode = 'i' },
  ['<F3>'] = { require('lsp_signature').toggle_float_win, 'lsp_signature.toggle_float_win', mode = { 'n', 'i' } },
  ['<F4>'] = { dap.restart_frame, 'dap.restart_frame' },
  ['<F5>'] = { dap.continue, 'dap.continue' },
  ['<F6>'] = { dapui.toggle_reset, 'dapui.toggle_reset' },
  ['<F7>'] = { neotest.run.dap, 'neotest.run.dap' },
  ['<F8>'] = { dap.toggle_breakpoint, 'dap.toggle_breakpoint' },
  ['<F9>'] = { neotest.run.buffer, 'run.buffer' },
  ['<F12>'] = { '<cmd>ToggleTerm direction=horizontal<CR>', 'ToggleTerm', mode = { 'n', 'i', 't' } },
  ['<F24>'] = { '<cmd>ToggleTerm direction=vertical<CR>', 'ToggleTerm', mode = { 'n', 'i', 't' } },
})

wkr({
  ---@diagnostic disable-next-line: undefined-field
  ['<leader>pa'] = { neotest.playwright.attachment, 'playwright.attachment' },
  ['<leader>pr'] = { [[:NeotestPlaywrightRefresh<CR>]], 'Refresh' },
  ['<leader>pp'] = { [[:NeotestPlaywrightPreset<CR>]], 'Preset' },
})

-- wkr({
--   name = 'Inspect',
--   t = { [[:InspectTree<cr>]], 'InspectTree' },
-- }, { prefix = '<leader>i' })

wkr({
  ['['] = {
    name = 'Previous',
    t = { require('todo-comments').jump_prev, 'todo-comments.jump_prev' },
    d = { vim.diagnostic.goto_prev, 'vim.diagnostic.goto_prev' },
  },
  [']'] = {
    name = 'Next',
    t = { require('todo-comments').jump_next, 'todo-comments.jump_next' },
    d = { vim.diagnostic.goto_next, 'vim.diagnostic.goto_next' },
  },
})
