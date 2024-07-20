{ pkgs, ... }: {
  programs.neovim.extraLuaPackages = ps: [
    ps.magick # image-nvim
  ];
  programs.neovim.plugins = with pkgs.vimPlugins; [
    sxhkd-vim
    persistent-breakpoints
    aerial-nvim
    auto-session
    {
      plugin = which-key-nvim;
      type = "lua";
      config = ''
      '';
    }
    {
      plugin = indent-blankline-nvim;
      config = "require('ibl').setup({})";
      type = "lua";
    }
    lazygit-nvim
    neogit
    gitsigns-nvim
    lualine-nvim
    lualine-lsp-progress
    nvim-tree-lua
    neorepl-nvim
    iron-nvim
    toggleterm-nvim
    {
      plugin = sqlite-lua;
      config = "let g:sqlite_clib_path = '${pkgs.sqlite.out}/lib/libsqlite3.so'";
    }
  ];
}
