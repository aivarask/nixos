{ pkgs, include, ... }:
let
  commonPlugins = with pkgs.vimPlugins; [
    fzf-vim
    switch-vim # switch.txt
    vim-highlightedyank # highlightedyank.txt	
  ];
in
{
  imports = [ ]
    ++ include ./tdd
    ++ include ./plugin
  ;
  programs.vim = {
    enable = true;
    plugins = commonPlugins ++ (with pkgs.vimPlugins; [
      # h local-additions
      # vim-repeat
      # vim-sensible
      # vim-matchit
      vim-surround
    ]);
    settings = { };
    extraConfig = ''
      let &runtimepath.=',/etc/nixos'
    '';
  };
  programs.neovim = {
    enable = true;
    plugins = commonPlugins;
    extraConfig = builtins.concatStringsSep "\n" [
      ''
        let &runtimepath.=',/etc/nixos'
      ''
    ];
    extraLuaConfig = builtins.concatStringsSep "\n" [

    ];
    # package = pkgs.neovim;
    # package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = false;
  };
}
