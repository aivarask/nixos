{ pkgs, ... }: {
  programs.neovim.extraLuaPackages = ps: [
    ps.magick # image-nvim
  ];
  programs.neovim.plugins = with pkgs.vimPlugins; [
    # TODO: project-nvim telescope-project-nvim
    # auto-session
    # https://github.com/Shatur/neovim-session-manager
    neovim-session-manager # plugin/_session.lua 
    {
      plugin = which-key-nvim;
      type = "lua";
      config = ''
        require('which-key').setup({})
        wkr = require('which-key').register
      '';
    }
    {
      plugin = indent-blankline-nvim;
      config = "require('ibl').setup({})";
      type = "lua";
    }
    lazygit-nvim
    lualine-nvim # plugin/_lualine.lua
    lualine-lsp-progress
    nvim-tree-lua # plugin/_nvim-tree.lua
    toggleterm-nvim
  ];
}
