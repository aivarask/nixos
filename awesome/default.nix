{ config, ... }:
{

  xdg.configFile."awesome".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/awesome";
}
