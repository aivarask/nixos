# DELL XPS 7590
# https://github.com/NixOS/nixos-hardware/tree/master/dell/xps/15-7590
{ config
, lib
, modulesPath
, ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

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

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    # video.hidpi.enable = lib.mkDefault true;
    # nvidia = { modesetting.enable = true; };

    nvidia.powerManagement.enable = true;
    nvidia.prime = {
      offload.enable = true;
      intelBusId = "PCI:0:2:0"; # lcpi
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
