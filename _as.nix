{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = ["xhci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
    initrd.kernelModules = [];
    kernelModules = ["kvm-intel"];
    extraModulePackages = [];
  };

  fileSystems = {
    "/" = {
      device = "zroot/root/nixos";
      fsType = "zfs";
    };
  };

  fileSystems."/home" = {
    device = "zroot/home";
    fsType = "zfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/37F7-8DDB";
    fsType = "vfat";
  };

  swapDevices = [];
  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
  system.stateVersion = "23.05";
  environment.variables = {
    MOZ_USE_XINPUT2 = "1";
  };

  networking = {
    hostName = "as";
    hostId = "8425e349";
    useDHCP = false;
    interfaces.enp2s0f2.useDHCP = true;
    interfaces.wlp3s0.useDHCP = true;
  };

  services.xserver = {
    dpi = 120;
    videoDrivers = ["modesetting"];
    libinput = {
      touchpad.naturalScrolling = true;
    };
  };

  services.xserver.displayManager.sddm.enable = true;
  networking.wireless.enable = false;
  networking.networkmanager.enable = true;
}
