{ config, ... }:
{
  programs.lf = {
    enable = true;
    # extraConfig = ''
    #   source /etc/nixos/lf/lf_hooks
    #   source /etc/nixos/lf/lfrc
    # '';
  };
  home.sessionVariables.PATH = [ "{$SELF}/lf/bin" ];
  xdg.configFile."lf".source = config.lib.file.mkOutOfStoreSymlink "{$SELF}/lf";
  # xdg.configFile."lf/icons".source = ./icons;
}
