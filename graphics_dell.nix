# https://discourse.nixos.org/t/suspend-issue-on-prime-nvidia-intel/74005
{ pkgs, lib, ... }:
{
  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";
  hardware.graphics.extraPackages = with pkgs; [
    # intel-media-driver
    intel-compute-runtime-legacy1
  ];
}
