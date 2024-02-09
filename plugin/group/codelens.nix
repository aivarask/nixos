{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins;[
    fold-preview
    goto-preview
    hover-nvim
    pretty-fold
  ];
}
