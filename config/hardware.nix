{ pkgs, lib, ... }:
{
  hardware.nvidia.modesetting.enable = lib.mkDefault true;
  hardware.nvidia.open = true;
}
