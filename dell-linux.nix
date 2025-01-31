{ pkgs, ... }:
{
  # boot.kernelPackages = pkgs.linuxPackages_latest; # fails zfs
  boot.blacklistedKernelModules = [
    "nouveou"
    "nvidiafb"
  ];
}
