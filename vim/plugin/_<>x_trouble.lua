wkr({
  ['<leader>x'] = {
    name = 'Trouble',
    x = { '<cmd>TroubleToggle<cr>', 'TroubleToggle' },
    l = { '<cmd>TroubleToggle loclist<cr>', 'loclist' },
    q = { '<cmd>TroubleToggle quickfix<cr>', 'quickfix' },
    d = { '<cmd>TroubleToggle document_diagnostics<cr>', 'document_diagnostics' },
    w = { '<cmd>TroubleToggle workspace_diagnostics<cr>', 'workspace_diagnostics' },
    r = { '<cmd>TroubleToggle lsp_references<cr>', 'lsp_references' },
    i = { '<cmd>TroubleToggle lsp_implementations<cr>', 'lsp_implementations' },
    D = { '<cmd>TroubleToggle lsp_definitions<cr>', 'lsp_definitions' },
    T = { '<cmd>TroubleToggle lsp_type_definitions<cr>', 'lsp_type_definitions' },
    a = { '<cmd>TroubleToggle todo<cr>', 'todo' },
    t = { '<cmd>TroubleToggle todo keywords=TODO,DONE<cr>', 'todo TODO,DONE' },
    f = { '<cmd>TroubleToggle todo keywords=FIX,ISSUE,BUG<cr>', 'todo FIX,ISSUE,BUG' },
    n = { '<cmd>TroubleToggle todo keywords=FIX,ISSUE,BUG<cr>', 'todo NOTE,INFO' },
  },
})

-- https://github.com/folke/trouble.nvim
require('trouble').setup({
  height = 15,
  auto_preview = false,
})
