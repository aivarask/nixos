{ pkgs, ... }:
let
  common = with pkgs.vimPlugins; [
    bclose-vim
    fzf-vim
    gruvbox-material # https://github.com/sainnhe/gruvbox-material
    lf-vim
    switch-vim # switch
    vim-abolish # abolish
    vim-commentary # commentary
    vim-cool
    vim-cursorword
    vim-devicons # devicons
    vim-floaterm # floaterm
    vim-highlightedyank # highlightedyank
    vim-interestingwords # https://github.com/lfv89/vim-interestingwords
    vim-lastplace
    vim-log-highlighting # https://github.com/MTDL9/vim-log-highlighting
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
        # h local-additions
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
