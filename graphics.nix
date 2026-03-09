# https://nixos.org/manual/nixos/stable/#sec-gpu-accel
# https://wiki.nixos.org/wiki/NVIDIA#
{
  pkgs,
  config,
  lib,
  ...
}:
{

  hardware.graphics.extraPackages = [
    pkgs.intel-compute-runtime-legacy1
    # pkgs.intel-ocl
  ];
  hardware.nvidia.open = true;
  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;
  hardware.nvidia.prime.intelBusId = lib.mkDefault "PCI:0:2:0";
  hardware.nvidia.prime.nvidiaBusId = lib.mkDefault "PCI:1:0:0";
  hardware.nvidia.powerManagement.enable = lib.mkDefault true;
  hardware.nvidia.powerManagement.finegrained = lib.mkDefault true;
}
