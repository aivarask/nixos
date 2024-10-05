{ ... }:
{
  environment.variables.HTOPRC = "/etc/nixos/files/htoprc";
  programs.htop = {
    enable = true;
    settings = {
      hide_kernel_threads = true;
      hide_userland_threads = true;
    };
  };
}
