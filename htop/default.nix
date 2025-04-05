{ config, ... }:
{
  programs.htop = {
    enable = true;
    settings = {
      hide_kernel_threads = true;
      hide_userland_threads = true;
    };
  };
  # HTOPRC=/etc/nixos/htop
  xdg.configFile."htop".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/htop";
}
