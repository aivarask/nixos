{
  config,
  lib,
  modulesPath,
  pkgs,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
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
