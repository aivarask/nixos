wkr({
  -- https://linuxize.com/post/how-to-use-linux-screen/
  -- https://github.com/akinsho/toggleterm.nvim#termexec
  d = {
    [[:2TermExec direction="vertical" cmd="screen -x foo" go_back=0<CR>]],
    ':TermExec cmd="screen -x foo"',
  },
  t = {
    function()
      local base = vim.fs.basename(vim.uv.cwd())
      vim.notify('Hello')
    end,
    '',
  },
}, { prefix = '<space>' })

-- local keys =
-- vim.api.nvim_replace_termcodes(':Git commit -m ""<Left>', false, false, true)
-- vim.api.nvim_feedkeys(keys, 'n', false)
