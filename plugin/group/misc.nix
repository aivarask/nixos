{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    symbols-outline-nvim
    flatten-nvim
    glow-nvim
    neoscroll-nvim
    dressing-nvim
    nvim-colorizer-lua
    nvim-web-devicons
  ];
}
