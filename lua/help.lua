local M = {}
M.select = function()
  local mode = vim.fn.mode()
  vim.ui.select({
    vim.fn.expand('<cword>'),
    vim.fn.expand('<cWORD>'),
    vim.fn.expand('<cfile>'),
    vim.fn.expand('<cexpr>'),
  }, {}, function(first)
    if first then
      local opts = {
        'help',
        'Man',
        'nixos-option -F self -r',
      }
      vim.ui.select(opts, {}, function(second)
        if second == 'help' then
          vim.cmd.help(first)
        elseif second == 'Man' then
          vim.cmd.Man(first)
        elseif second == opts[3] then
          vim.cmd('!' .. second .. ' ' .. first)
        else
        end
      end)
    end
  end)
end

return M
