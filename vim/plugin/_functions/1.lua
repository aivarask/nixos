function sveltekit_file()
  local api = require('nvim-tree.api')
  return vim.ui.select({ '+page.server.ts', '+page.svelte', '+server.ts' }, {
    prompt = 'New file',
    format_item = function(item) return item end,
  }, function(item)
    if item == nil then
      return
    else
      local node = api.tree.get_node_under_cursor()
      local path
      if node.fs_stat.type == 'directory' then
        if node then
          path = node.absolute_path .. '/' .. item
        else
          path = node.parent.absolute_path .. '/' .. item
        end
      else
        path = vim.fn.expand('%:h') .. '/' .. item
      end
      vim.cmd.edit(path)
    end
  end)
end

function help_cword() vim.cmd.help(vim.fn.expand('<cword>')) end

function help_cWORD() vim.cmd.help(vim.fn.expand('<cWORD>')) end

function help_cexpr() vim.cmd.help(vim.fn.expand('<cexpr>')) end

function cmp_complete_luasnip()
  require('cmp').complete({ config = { sources = { { name = 'luasnip' } } } })
end
