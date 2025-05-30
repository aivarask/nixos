{ config, ... }:
{
  xdg.configFile."touchegg".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/touchegg";
}
