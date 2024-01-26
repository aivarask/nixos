{ lib, ... }: {
  hardware.nvidia.modesetting.enable = lib.mkDefault true;
}
