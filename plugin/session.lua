-- vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.o.sessionoptions = "buffers,curdir"

-- auto-session
require("auto-session").setup({
  session_lens = {
    buftypes_to_ignore = {},
    load_on_setup = true,
    theme_conf = { border = true },
    previewer = false,
  },
  auto_session_suppress_dirs = { "~/", "~/Downloads", "/nix/store" },
  post_restore_cmds = {
    -- require('neotest').summary.open,
  },
})
require("telescope").load_extension("session-lens")
