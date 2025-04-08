{ config, ... }:
{
  programs.ncmpcpp.enable = true;
  xdg.configFile."ncmpcpp".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/ncmpcpp";
}
