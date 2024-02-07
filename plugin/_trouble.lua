wkr({
  ['<leader>x'] = {
    name = 'Trouble',
    D = { '<cmd>TroubleToggle lsp_definitions<cr>', 'lsp_definitions' },
    T = {
      '<cmd>TroubleToggle lsp_type_definitions<cr>',
      'lsp_type_definitions',
    },
    a = { '<cmd>TroubleToggle todo<cr>', 'todo' },
    d = {
      '<cmd>TroubleToggle document_diagnostics<cr>',
      'document_diagnostics',
    },
    f = {
      '<cmd>TroubleToggle todo keywords=FIX,ISSUE,BUG<cr>',
      'todo FIX,ISSUE,BUG',
    },
    i = { '<cmd>TroubleToggle lsp_implementations<cr>', 'lsp_implementations' },
    l = { '<cmd>TroubleToggle loclist<cr>', 'loclist' },
    n = {
      '<cmd>TroubleToggle todo keywords=FIX,ISSUE,BUG<cr>',
      'todo NOTE,INFO',
    },
    q = { '<cmd>TroubleToggle quickfix<cr>', 'quickfix' },
    r = { '<cmd>TroubleToggle lsp_references<cr>', 'lsp_references' },
    t = { '<cmd>TroubleToggle todo keywords=TODO,DONE<cr>', 'todo TODO,DONE' },
    w = {
      '<cmd>TroubleToggle workspace_diagnostics<cr>',
      'workspace_diagnostics',
    },
    x = { '<cmd>TroubleToggle<cr>', 'TroubleToggle' },
  },
})

-- https://github.com/folke/trouble.nvim
require('trouble').setup({
  height = 15,
  auto_preview = false,
})

-- https://github.com/folke/todo-comments.nvim
require('todo-comments').setup({
  sign_priority = 11,
  keywords = {
    -- REL: Related, link
    REL = { icon = '🔗', color = 'neutral', { alt = { 'LINK' } } },
    -- DOCS: Folowing links
    DOCS = { icon = '📖', color = 'sky' },
    -- TODO:: new todo is waiting
    TODO = { icon = '☑️', color = 'blue' },
    -- DONE:: This is done
    DONE = { icon = '✅', color = 'lime' },
    -- FIX:
    FIX = { icon = '🐞', color = 'red', { alt = { 'ISSUE', 'BUG' } } },
    -- NOTE:
    NOTE = { icon = 'ℹ️ ', color = 'cyan', alt = { 'INFO', 'USE' } },
    -- TEST: Fire
    TEST = { icon = '🔥', color = 'amber' },
    -- FEAT: Robot
    FEAT = { icon = '🤖', color = 'sky' },
    -- EXPER: DNA
    EXPER = { icon = '🧬', color = 'purple' },
    -- IDEA:
    IDEA = { icon = '💡', color = 'yellow' },
  },
  colors = {
    slate = { '#64748b' },
    gray = { '#6b7280' },
    zinc = { '#71717a' },
    neutral = { '#737373' },
    stone = { '#78716c' },
    red = { '#ef4444' },
    orange = { '#f97316' },
    amber = { '#f59e0b' },
    yellow = { '#eab308' },
    lime = { '#84cc16' },
    green = { '#22c55e' },
    emerald = { '#10b981' },
    teal = { '#14b8a6' },
    cyan = { '#06b6d4' },
    sky = { '#0ea5e9' },
    blue = { '#3b82f6' },
    indigo = { '#6366f1' },
    violet = { '#8b5cf6' },
    purple = { '#a855f7' },
    fuchsia = { '#d946ef' },
    pink = { '#ec4899' },
    rose = { '#f43f5e' },
    --
    error = { 'DiagnosticError', 'ErrorMsg', '#DC2626' },
    warning = { 'DiagnosticWarn', 'WarningMsg', '#FBBF24' },
    info = { 'DiagnosticInfo', '#2563EB' },
    hint = { 'DiagnosticHint', '#10B981' },
    default = { 'Identifier', '#7C3AED' },
    test = { 'Identifier', '#FF00FF' },
  },
  search = {
    command = 'rg',
    args = {
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--glob=!node_modules',
      '--glob=!build',
    },
    -- regex that will be used to match keywords.
    -- don't replace the (KEYWORDS) placeholder
    pattern = [[\b(KEYWORDS):]], -- ripgrep regex
    -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
  },
})
