function mh(scope, expand)
  local expanded = vim.fn.expand(expand)
  vim.cmd([[!nix eval nixpkgs\#]] .. scope .. expanded .. [[.meta.homepage | xargs xdg-open]])
end

function xo(expand)
  local arg = vim.fn.escape(vim.fn.expand(expand), '#')
  vim.cmd([[!xdg-open ]] .. arg)
end

local M = {
  homepage = {
    cword = function() -- bat
      mh('', '<cword>')
    end,
    cWORD = function()
      mh('', '<cWORD>') -- prisma-engines
    end,
  },
  luajitPackages = {
    cword = function() -- busted
      mh('luajitPackages.', '<cword>')
    end,
    cWORD = function() -- plenary-nvim
      mh('luajitPackages.', '<cWORD>')
    end,
  },
  python3Packages = {
    cword = function() -- pynvim
      mh('python3Packages.', '<cword>')
    end,
    cWORD = function() -- python-lsp-server
      mh('python3Packages.', '<cWORD>')
    end,
  },
  nodePackages = {
    cword = function() -- typescript
      mh('nodePackages_latest.', '<cword>')
    end,
    cWORD = function() -- npm-check-updates
      mh('nodePackages_latest.', '<cWORD>')
    end,
  },
  vimPlugins = {
    cword = function() -- neotest
      mh('vimPlugins.', '<cword>')
    end,
    cWORD = function() -- neotest-vitest
      mh('vimPlugins.', '<cWORD>')
    end,
  },
  xopen = {
    cfile = function() -- https://github.com/aivarask
      xo('<cfile>')
    end,
  },
}

wkr({
  name = 'GOTO',
  h = { M.homepage.cword, 'nixpkgs#<cword>.meta.homepage' },
  H = { M.homepage.cWORD, 'nixpkgs#<cWORD>.meta.homepage' },
  l = { M.luajitPackages.cword, 'luajitPackages.<cword>.meta.homepage' },
  L = { M.luajitPackages.cWORD, 'luajitPackages.<cWORD>.meta.homepage' },
  p = { M.python3Packages.cword, 'python3Packages.<cword>.meta.homepage' },
  P = { M.python3Packages.cWORD, 'python3Packages.<cWORD>.meta.homepage' },
  n = { M.nodePackages.cword, 'nodePackages.<cword>.meta.homepage' },
  N = { M.nodePackages.cWORD, 'nodePackages.<cWORD>.meta.homepage' },
  v = { M.vimPlugins.cword, 'vimPlugins.<cword>.meta.homepage' },
  V = { M.vimPlugins.cWORD, 'vimPlugins.<cWORD>.meta.homepage' },
  x = { M.xopen.cfile, '!xdg-open <cfile>' },
  --
  g = { GoGithub, 'github:owner/repo' },
}, { prefix = '<leader>g' })
