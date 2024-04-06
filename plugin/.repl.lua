-- https://github.com/ii14/neorepl.nvim
-- https://github.com/Vigemus/iron.nvim
-- iron.nvim -- iron-nvim
local iron = require("iron.core")

iron.setup({
  config = {
    scratch_repl = false,
    repl_definition = {
      -- lua = require("iron.fts.lua"),
      sh = {
        command = { "zsh" },
      },

    },
    repl_open_cmd = require('iron.view').right('40%'),
  },
  keymaps = {
    send_motion = "<space>sc",
    visual_send = "<space>sc",
    send_file = "<space>sf",
    send_line = "<space>sl",
    send_until_cursor = "<space>su",
    send_mark = "<space>sm",
    mark_motion = "<space>mc",
    mark_visual = "<space>mc",
    remove_mark = "<space>md",
    cr = "<space>s<cr>",
    interrupt = "<space>s<space>",
    exit = "<space>sq",
    clear = "<space>cl",
  },

  -- If the highlight is on, you can change how it looks
  -- For the available options, check nvim_set_hl
  -- highlight = {
  -- italic = true,
  -- },
  ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
})

vim.keymap.set('n', '<space>rs', '<cmd>IronRepl<cr>')
vim.keymap.set('n', '<space>rr', '<cmd>IronRestart<cr>')
vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')
