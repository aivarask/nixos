{ pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins;[
    fold-preview-nvim
    goto-preview
    hover-nvim
    pretty-fold-nvim
  ];
}
