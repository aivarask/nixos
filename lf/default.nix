{ config, pkgs, ... }:
{
  # programs.lf.enable = true;
  # programs.lf = {
  # enable = true;
  # extraConfig = ''
  #   source /etc/nixos/lf/lf_hooks
  #   source /etc/nixos/lf/lfrc
  # '';
  # };
  home.sessionPath = [ "/etc/nixos/lf/bin" ];
  home.packages = [
    pkgs.lf
    # (pkgs.buildEnv {
    #   name = "my-scripts";
    #   paths = [ ./path/to/scripts ];
    # })
  ];
  xdg.configFile."lf".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/lf";
  # xdg.configFile."lf/icons".source = ./icons;
}
