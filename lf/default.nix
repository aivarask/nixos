{ config, pkgs, ... }:
{
  home.packages = [ pkgs.lf ];
  # programs.lf.enable = true;
  # programs.lf = {
  # enable = true;
  # extraConfig = ''
  #   source /etc/nixos/lf/lf_hooks
  #   source /etc/nixos/lf/lfrc
  # '';
  # };
  home.sessionPath = [ "/etc/nixos/lf/bin" ];
  xdg.configFile."lf".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/lf";
  # xdg.configFile."lf/icons".source = ./icons;
}
