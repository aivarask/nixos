-- vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.o.sessionoptions = "buffers,curdir"

require('which-key').register({
  ['<F10>'] = { [[:Telescope session-lens<CR>]], "session-lens" },
})
-- auto-session
require("auto-session").setup({
  session_lens = {
    buftypes_to_ignore = {},
    load_on_setup = true,
    theme_conf = { border = true },
    previewer = false,
  },
})
require("telescope").load_extension("session-lens")
