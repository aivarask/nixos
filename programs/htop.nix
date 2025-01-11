{ ... }:
{
  environment.variables.HTOPRC = "/etc/nixos/programs/htoprc";
  programs.htop = {
    enable = true;
    settings = {
      hide_kernel_threads = true;
      hide_userland_threads = true;
    };
  };
}
