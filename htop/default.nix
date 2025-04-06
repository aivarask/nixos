{ config, ... }:
{
  programs.htop.enable = true;
  xdg.configFile."htop".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/htop";
}
