{ pkgs, include, ... }: {
  imports = [ ]
    ++ include ./plugin
    ++ include ./plugin/group
  ;
  programs.neovim = {
    enable = true;
    extraConfig = builtins.concatStringsSep "\n" [
      ''
        let &runtimepath.=',/etc/nixos'
        lua << EOF
        dofile("/etc/nixos/init.lua")
        EOF
      ''
    ];
    package = pkgs.neovim-nightly;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = false;
  };
  programs.vim = {
    enable = true;
    # plugins = commonPlugins;
    extraConfig = ''
      let &runtimepath.=',/etc/nixos'
      source /etc/nixos/vimrc.vim
    '';
  };
}
