# https://discourse.nixos.org/t/suspend-issue-on-prime-nvidia-intel/74005
{ pkgs, lib, ... }:
{
  services.graphical-desktop.enable = lib.mkDefault true;
  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";

  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    intel-compute-runtime-legacy1
  ];

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.dynamicBoost.enable = true;
  hardware.nvidia.open = true;
  hardware.nvidia.powerManagement.enable = true;
  hardware.nvidia.powerManagement.finegrained = true;

}
