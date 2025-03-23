# https://github.com/nicolas-goudry/nix-config/blob/main/hosts/g-xps/default.nix
{
  config,
  lib,
  modulesPath,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.nixos-hardware.nixosModules.dell-xps-15-7590-nvidia
    inputs.nixos-hardware.nixosModules.common-gpu-intel-disable
    ./binarycache.nix
    # ./bluetooth.nix
    ./boot.nix
    ./hardware.nix
    ./kmscon.nix
    ./network.nix
    ./qt.nix
    ./storage.nix
    # ./virt.nix
  ];

  system.stateVersion = "23.05";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  services.switcherooControl.enable = true;
  services.xserver.dpi = 283;

}
