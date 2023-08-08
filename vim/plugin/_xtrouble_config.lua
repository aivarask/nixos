wkr({
  ['<leader>x'] = {
    name = 'Trouble',
    D = { '<cmd>TroubleToggle lsp_definitions<cr>', 'lsp_definitions' },
    T = { '<cmd>TroubleToggle lsp_type_definitions<cr>', 'lsp_type_definitions' },
    a = { '<cmd>TroubleToggle todo<cr>', 'todo' },
    d = { '<cmd>TroubleToggle document_diagnostics<cr>', 'document_diagnostics' },
    f = { '<cmd>TroubleToggle todo keywords=FIX,ISSUE,BUG<cr>', 'todo FIX,ISSUE,BUG' },
    i = { '<cmd>TroubleToggle lsp_implementations<cr>', 'lsp_implementations' },
    l = { '<cmd>TroubleToggle loclist<cr>', 'loclist' },
    n = { '<cmd>TroubleToggle todo keywords=FIX,ISSUE,BUG<cr>', 'todo NOTE,INFO' },
    q = { '<cmd>TroubleToggle quickfix<cr>', 'quickfix' },
    r = { '<cmd>TroubleToggle lsp_references<cr>', 'lsp_references' },
    t = { '<cmd>TroubleToggle todo keywords=TODO,DONE<cr>', 'todo TODO,DONE' },
    w = { '<cmd>TroubleToggle workspace_diagnostics<cr>', 'workspace_diagnostics' },
    x = { '<cmd>TroubleToggle<cr>', 'TroubleToggle' },
  },
})

-- https://github.com/folke/trouble.nvim
require('trouble').setup({
  height = 15,
  auto_preview = false,
})
