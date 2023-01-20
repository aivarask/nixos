vim.keymap.set('n', ']t', require('todo-comments').jump_next, { desc = 'todo-comments.jump_prev()' })
vim.keymap.set('n', '[t', require('todo-comments').jump_prev, { desc = 'todo-comments.jump_prev()' })
vim.keymap.set({ 'n', 'i', 'v' }, '<F9>', '<cmd>TroubleToggle todo<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<F21>', '<cmd>TroubleToggle todo<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<F33>', '<cmd>TroubleToggle todo<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<F10>', '<cmd>Trouble todo keywords=TODO,DONE<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<F22>', '<cmd>Trouble todo keywords=FIX,ISSUE,BUG<CR>')
vim.keymap.set({ 'n', 'i', 'v' }, '<F34>', '<cmd>Trouble todo keywords=NOTE,INFO<CR>')

-- https://github.com/folke/todo-comments.nvim#%EF%B8%8F-configuration
require('todo-comments').setup({
  signs = true,
  sign_priority = 11,
  merge_keywords = true, -- when true, custom keywords will be merged with the defaults
  keywords = {
    -- TODO:: new todo is waiting
    TODO = { icon = '☑️', color = 'blue' },
    -- DONE:: This is done
    DONE = { icon = '✅', color = 'lime' },
    -- FIX:
    FIX = { icon = '🐞', color = 'red', { alt = { 'ISSUE', 'BUG' } } },
    -- NOTE:
    NOTE = { icon = 'ℹ️ ', color = 'cyan', alt = { 'INFO' } },

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
  gui_style = {
    fg = 'NONE',
    bg = 'BOLD',
  },
  -- highlighting of the line containing the todo comment
  -- * before: highlights before the keyword (typically comment characters)
  -- * keyword: highlights of the keyword
  -- * after: highlights after the keyword (todo text)
  highlight = {
    multiline = true, -- enable multine todo comments
    multiline_pattern = '^.', -- lua pattern to match the next multiline from the start of the matched keyword
    multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
    before = '', -- "fg" or "bg" or empty
    keyword = 'wide', -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
    after = 'fg', -- "fg" or "bg" or empty
    pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
    comments_only = true, -- uses treesitter to match keywords in comments only
    max_line_len = 400, -- ignore lines longer than this
    exclude = {}, -- list of file types to exclude highlighting
  },
  search = {
    command = 'rg',
    args = {
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
    },
    -- regex that will be used to match keywords.
    -- don't replace the (KEYWORDS) placeholder
    pattern = [[\b(KEYWORDS):]], -- ripgrep regex
    -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
  },
})
