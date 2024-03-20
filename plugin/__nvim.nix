{ pkgs, ... }: {
  programs.neovim.extraLuaPackages = ps: [
    ps.magick # image-nvim
  ];
  programs.neovim.plugins = with pkgs.vimPlugins; [
    sxhkd-vim
    # persistent-breakpoints
    aerial-nvim
    auto-session
    {
      plugin = which-key-nvim;
      type = "lua";
      config = ''
        require('which-key').setup({})
      '';
    }
    {
      plugin = indent-blankline-nvim;
      config = "require('ibl').setup({})";
      type = "lua";
    }
    lazygit-nvim
    lualine-nvim
    lualine-lsp-progress
    nvim-tree-lua
    toggleterm-nvim
  ];
}
