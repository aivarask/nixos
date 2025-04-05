{ ... }:
{
  # HTOPRC
  programs.htop = {
    enable = true;
    settings = {
      hide_kernel_threads = true;
      hide_userland_threads = true;
    };
  };
  xdg.configFile."htop".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/htop";
}
