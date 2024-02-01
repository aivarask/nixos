function help_cword() vim.cmd.help(vim.fn.expand('<cword>')) end

function help_cWORD() vim.cmd.help(vim.fn.expand('<cWORD>')) end

function help_cexpr() vim.cmd.help(vim.fn.expand('<cexpr>')) end

function custom_yank() vim.fn.setreg('p', vim.fn.expand('%:p')) end

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

function homepage(scope, expand)
  local expanded = vim.fn.expand(expand)
  vim.cmd(
    [[!nix eval nixpkgs\#]]
    .. scope
    .. expanded
    .. [[.meta.homepage | xargs xdg-open]]
  )
end

function xo(expand)
  local arg = vim.fn.escape(vim.fn.expand(expand), '#')
  vim.cmd([[!xdg-open ]] .. arg)
end

function mynixos(expand) -- pointerCursor home.pointerCursor
  local arg = vim.fn.expand(expand)
  vim.cmd([[!xdg-open "https://mynixos.com/search?q=]] .. arg .. '"')
end

function GoGithub()
  -- "github:nix-community/neovim-nightly-overlay";
  local pre = 'https://github.com/'
  local word = vim.fn.expand('<cWORD>')
  word = word:gsub('github:', pre)
  word = word:gsub(';', '')
  vim.cmd('!xdg-open ' .. word)
end
