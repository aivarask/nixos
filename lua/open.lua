local wk = require('which-key')



wk.add({

  { '-', '<cmd>cd ..<CR>' },
  {
    '<F1>',
    function()
      vim.cmd.help(vim.fn.expand('<cword>'))
    end,
    mode = { 'n', 'i', 'v' },
  },
  { 'qq', [[:NvimTreeToggle<CR>]], noremap = true },
  { 'qw', [[:NvimTreeCollapse<CR>]] },
})

vim.cmd([[
	cabbrev == lua= print('foo')
]])

function get_visual_selection()
  local s_start = vim.fn.getpos("'<")
  local s_end = vim.fn.getpos("'>")
  local n_lines = math.abs(s_end[2] - s_start[2]) + 1
  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
  lines[1] = string.sub(lines[1], s_start[3], -1)
  if n_lines == 1 then
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
  else
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
  end
  -- return table.concat(lines, '\n')
  print(table.concat(lines, '\n'))
end

wk.add({
  {
    '<F3>',
    function()
      local mode = vim.fn.mode()
      vim.ui.select({
        vim.fn.expand('<cword>'),
        vim.fn.expand('<cWORD>'),
        vim.fn.expand('<cfile>'),
        vim.fn.expand('<cexpr>'),
      }, {}, function(item, idx)
        if item then
          vim.cmd.help(item)
        end
      end)
    end,
    mode = { 'n', 'i', 'v' },
  },
})
