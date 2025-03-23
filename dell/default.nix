{
  config,
  lib,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./binarycache.nix
    ./gpu.nix
    ./network
  ];
  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "sd_mod"
      "rtsx_pci_sdmmc"
      "usb_storage"
    ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };
  # boot.kernelPackages = pkgs.linuxPackages_latest; # fails zfs
  boot.blacklistedKernelModules = [
    "nouveou"
    "nvidiafb"
  ];
  fileSystems = {
    "/" = {
      device = "zroot/root/nixos";
      fsType = "zfs";
    };
    "/home" = {
      device = "zroot/home";
      fsType = "zfs";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/CFAB-7FF4";
      fsType = "vfat";
    };
  };
  swapDevices = [

  ];

  system.stateVersion = "23.05";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  services.switcherooControl.enable = true;
  # For GeForce GTX 1650 nvidia.com recommends 550 version (stable), but 570 (beta) returns from suspend
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;

}
