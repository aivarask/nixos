{ config, ... }:
{
  xdg.configFile."picom.conf".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/picom/picom.conf";
}
