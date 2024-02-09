-- https://github.com/windwp/nvim-autopairs
local npairs = require('nvim-autopairs')

-- https://github.com/windwp/nvim-autopairs#default-values
local disable_filetype = { 'TelescopePrompt', 'spectre_panel' }
local disable_in_macro = true        -- disable when recording or executing a macro
local disable_in_visualblock = false -- disable when insert after visual block mode
local disable_in_replace_mode = true
local ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=]
local enable_moveright = true
local enable_afterquote = true         -- add bracket pairs after quote
local enable_check_bracket_line = true --- check bracket in same line
local enable_bracket_in_quote = true   --
local enable_abbr = false              -- trigger abbreviation
local break_undo = true                -- switch for basic rule break undo sequence
local check_ts = false
local map_cr = true
local map_bs = true   -- map the <BS> key
local map_c_h = false -- Map the <C-h> key to delete a pair
local map_c_w = false -- map <c-w> to delete a pair if possible

npairs.setup({
  -- changed defaults
  map_c_h = true,
  map_c_w = true,
  -- https://github.com/windwp/nvim-autopairs#fastwrap
  -- Before        Input                    After         Note
  -----------------------------------------------------------------
  -- (|foobar      <M-e> then press $       (|foobar)
  -- (|)(foobar)   <M-e> then press q       (|(foobar))
  -- (|foo bar     <M-e> then press qh      (|foo) bar
  -- (|foo bar     <M-e> then press qH      (foo|) bar
  -- (|foo bar     <M-e> then press qH      (foo)| bar    if cursor_pos_before = false
  fast_wrap = {
    fast_wrap = {
      map = '<M-e>',
      chars = { '{', '[', '(', '"', "'" },
      pattern = [=[[%'%"%>%]%)%}%,]]=],
      end_key = '$',
      before_key = 'h',
      after_key = 'l',
      cursor_pos_before = true,
      keys = 'qwertyuiopzxcvbnmasdfghjkl',
      manual_position = true,
      highlight = 'Search',
      highlight_grey = 'Comment',
    },
  },
})
