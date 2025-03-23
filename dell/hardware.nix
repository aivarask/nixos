{ config, ... }:
{
  # For GeForce GTX 1650 nvidia.com recommends 550 version (stable), but 570 (beta) returns from suspend
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
}
