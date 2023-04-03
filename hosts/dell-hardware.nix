# DELL XPS 7590
{ config
, lib
, modulesPath
, ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "sd_mod"
      "rtsx_pci_sdmmc"
      "usb_storage" # added ssd
    ];
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
    nvidia.modesetting.enable = true;
    bluetooth.enable = false;
  };
}
