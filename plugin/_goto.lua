function homepage(scope, expand)
  local expanded = vim.fn.expand(expand)
  -- [[!nix eval nixpkgs\#]]
  local host = vim.uv.os_gethostname()
  vim.cmd(
    [[!nix eval nixos\#nixosConfigurations.]] .. host .. [[.pkgs.]]
    .. scope
    .. expanded
    .. [[.meta.homepage | xargs xdg-open]]
  )
end

Go = {
  homepage = {
    cword = function()
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
    cWORD = function()
      homepage('nodePackages_latest.', '<cWORD>')
    end,
  },
  vimPlugins = {
    cword = function()
      homepage('vimPlugins.', '<cword>')
    end,
    cWORD = function()
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
  github = {
    source = function()
      local pre = 'https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos'
      local p = ''
      print(vim.fn.expand('%:t'))
      if vim.fn.expand('%:t') == 'default.nix' then
        p = vim.fn.expand('%:p:h')
      else
        p = vim.fn.expand('%:p')
      end
      local post = p:gsub('/etc/nixos', pre)
      vim.cmd([[!xdg-open ]] .. post)
    end,
  },
  c = {},
}
require('which-key').register({
  name = 'GOTO',
  h = { Go.homepage.cword, 'nixpkgs#<cword>.meta.homepage' },
  H = { Go.homepage.cWORD, 'nixpkgs#<cWORD>.meta.homepage' },
  l = { Go.luajitPackages.cword, 'luajitPackages.<cword>.meta.homepage' },
  L = { Go.luajitPackages.cWORD, 'luajitPackages.<cWORD>.meta.homepage' },
  p = { Go.python3Packages.cword, 'python3Packages.<cword>.meta.homepage' },
  P = { Go.python3Packages.cWORD, 'python3Packages.<cWORD>.meta.homepage' },
  n = { Go.nodePackages.cword, 'nodePackages.<cword>.meta.homepage' },
  N = { Go.nodePackages.cWORD, 'nodePackages.<cWORD>.meta.homepage' },
  v = { Go.vimPlugins.cword, 'vimPlugins.<cword>.meta.homepage' },
  V = { Go.vimPlugins.cWORD, 'vimPlugins.<cWORD>.meta.homepage' },
  x = { Go.xopen.cfile, '!xdg-open <cfile>' },
  m = { Go.mynixos.cword, 'mynixos.org <cword>' },
  M = { Go.mynixos.cWORD, 'mynixos.org <cWORD>' },
  s = { Go.github.source, 'github.source' },
  g = { GoGithub, 'github:owner/repo' },
}, { prefix = '<leader>g' })
