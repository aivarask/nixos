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

Go = {
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
