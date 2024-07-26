{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    aerial-nvim
    outline-nvim
    flatten-nvim
    glow-nvim
    neoscroll-nvim
    dressing-nvim
    nvim-colorizer-lua
    nvim-web-devicons
    image-nvim
  ];
}
