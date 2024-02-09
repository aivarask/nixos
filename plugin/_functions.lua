function help_cword() vim.cmd.help(vim.fn.expand('<cword>')) end

function help_cWORD() vim.cmd.help(vim.fn.expand('<cWORD>')) end

function help_cexpr() vim.cmd.help(vim.fn.expand('<cexpr>')) end

function custom_yank() vim.fn.setreg('p', vim.fn.expand('%:p')) end

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
