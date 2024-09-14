{ pkgs, ... }:
let
  common = with pkgs.vimPlugins; [
    bclose-vim
    fzf-vim
    gruvbox-material
    lf-vim
    switch-vim
    vim-abolish
    vim-commentary
    vim-cool
    vim-cursorword
    vim-devicons
    vim-floaterm
    vim-highlightedyank
    vim-lastplace
    vim-matchup
    direnv-vim
  ];
in
{
  programs.vim = {
    enable = true;
    plugins =
      common
      ++ (with pkgs.vimPlugins; [
        # vim-repeat vim-sensible vim-matchit
        vim-surround
        auto-pairs
      ]);
    settings = { };
    extraConfig = ''
      let &runtimepath.=',/etc/nixos'
    '';
  };
  programs.neovim = {
    enable = true;
    plugins =
      common
      ++ (with pkgs.vimPlugins; [
        vim-sensible
      ]);
    extraConfig = builtins.concatStringsSep "\n" [
      ''
        let &runtimepath.=',/etc/nixos'
      ''
    ];
    extraLuaConfig = builtins.concatStringsSep "\n" [

    ];
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = false;
  };
}
