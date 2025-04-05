{ config, ... }:
{
  programs.htop = {
    enable = true;
  };
  # HTOPRC=/etc/nixos/htop
  xdg.configFile."htop".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/htop";
}
