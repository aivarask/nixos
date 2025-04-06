{ config, ... }:
{
  services.sxhkd.enable = true;
  xdg.configFile."sxhkd".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/sxhkd";
}
