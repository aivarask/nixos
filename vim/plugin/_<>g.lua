function homepage(scope, expand)
  local expanded = vim.fn.expand(expand)
  vim.cmd([[!nix eval nixpkgs\#]] .. scope .. expanded .. [[.meta.homepage | xargs xdg-open]])
end

function xo(expand)
  local arg = vim.fn.escape(vim.fn.expand(expand), '#')
  vim.cmd([[!xdg-open ]] .. arg)
end

function mynixos(expand) -- pointerCursor home.pointerCursor
  local arg = vim.fn.expand(expand)
  vim.cmd([[!xdg-open "https://mynixos.com/search?q=]] .. arg .. '"')
end

local M = {
  homepage = {
    cword = function() -- bat
      homepage('', '<cword>')
    end,
    cWORD = function()
      homepage('', '<cWORD>') -- prisma-engines
    end,
  },
  luajitPackages = {
    cword = function() -- busted
      homepage('luajitPackages.', '<cword>')
    end,
    cWORD = function() -- plenary-nvim
      homepage('luajitPackages.', '<cWORD>')
    end,
  },
  python3Packages = {
    cword = function() -- pynvim
      homepage('python3Packages.', '<cword>')
    end,
    cWORD = function() -- python-lsp-server
      homepage('python3Packages.', '<cWORD>')
    end,
  },
  nodePackages = {
    cword = function() -- typescript
      homepage('nodePackages_latest.', '<cword>')
    end,
    cWORD = function() -- npm-check-updates
      homepage('nodePackages_latest.', '<cWORD>')
    end,
  },
  vimPlugins = {
    cword = function() -- neotest
      homepage('vimPlugins.', '<cword>')
    end,
    cWORD = function() -- neotest-vitest
      homepage('vimPlugins.', '<cWORD>')
    end,
  },
  xopen = {
    cfile = function() -- https://github.com/aivarask
      xo('<cfile>')
    end,
  },
  mynixos = {
    cword = function() -- pointerCursor
      mynixos('<cword>')
    end,
    cWORD = function() -- home.pointerCursor
      mynixos('<cWORD>')
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
  m = { M.mynixos.cword, 'mynixos.org <cword>' },
  M = { M.mynixos.cWORD, 'mynixos.org <cWORD>' },
  --
  g = { GoGithub, 'github:owner/repo' },
}, { prefix = '<leader>g' })
