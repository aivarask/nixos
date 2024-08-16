{ pkgs, include, inputs, ... }: {
  imports = [ ]
    ++ include ./tdd
    ++ include ./plugin
  ;
  programs.neovim = {
    enable = true;
    extraConfig = builtins.concatStringsSep "\n" [
      ''
        let &runtimepath.=',/etc/nixos'
      ''
    ];
    extraLuaConfig = builtins.concatStringsSep "\n" [

    ];
    # package = pkgs.neovim;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
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
    '';
  };
}
