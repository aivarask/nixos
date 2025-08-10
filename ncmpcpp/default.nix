{ config, ... }:
{
  programs.ncmpcpp.enable = true;
  xdg.configFile."ncmpcpp" = {
    enable = false;
    force = true;
    source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/ncmpcpp";
  };
}
