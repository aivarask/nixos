wkr({
  name = 'GOTO',
  x = {
    function()
      local arg = vim.fn.escape(vim.fn.expand('<cfile>'), '#')
      -- arg = vim.fn.escape
      vim.cmd([[!xdg-open ]] .. arg)
    end,
    '!xdg-open <cfile>',
  },
  h = {
    function()
      vim.cmd([[!nix eval nixpkgs\#]] .. vim.fn.expand('<cword>') .. [[.meta.homepage | xargs xdg-open]])
    end,
    '!nix eval nixpkgs#<cword>.meta.homepage | xargs xdg-open',
  },
  H = {
    function()
      vim.cmd([[!nix eval nixpkgs\#]] .. vim.fn.expand('<cWORD>') .. [[.meta.homepage | xargs xdg-open]])
    end,
    '!nix eval nixpkgs#<cWORD>.meta.homepage | xargs xdg-open',
  },
  g = { GoGithub, 'github:owner/repo' },
}, { prefix = '<leader>g' })
