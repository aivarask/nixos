{ config, ... }:
{
  programs.ncmpcpp.enable = true;
  xdg.configFile."ncmpcpp/config" = {
    enable = true;
    force = true;
    source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/ncmpcpp/config";
  };
  xdg.configFile."ncmpcpp/bindings" = {
    enable = true;
    force = true;
    source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/ncmpcpp/bindings";
  };
}
