{ config, pkgs, ... }:
{
  home.sessionPath = [ "/etc/nixos/lf/bin" ];
  home.packages = [ pkgs.lf ];
  xdg.configFile."lf".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/lf";
}
