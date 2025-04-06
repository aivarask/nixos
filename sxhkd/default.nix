{ config, ... }:
{
#
#
# home
#
# about
  services.sxhkd.enable = true;
  xdg.configFile."sxhkd/sxhkdrc".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/sxhkd/sxhkdrc";
}
