-- vim.split
-- os.getenv
-- % is escape char in Lua


local matchers = {
  -- DAP
  'nvim%-dap',
  -- LSP
  'nvim%-lspconfig',
  'SchemaStore%.nvim',
  'none%-ls.nvim',
  -- COMPLETION
  'nvim%-cmp',
  -- 'nvim%-autopairs',
  --   NEOTEST
  'neotest$',
  'neotest%-plenary$',
  'neotest%-vitest$',
  'neotest%-playwright$',
  -- UI
  'project.nvim',
  'session%-manager',
  'nvim%-tree',
  'telescope.nvim',
  'dressing.nvim',
  'toggleterm.nvim',
  'lualine.nvim',
  -- KEYMAPS
  'which%-key%-nvim',
}

