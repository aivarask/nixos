# vim:foldlevel=3
{
  config,
  lib,
  modulesPath,
  ...
}:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
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
  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
  };
  services.blueman.enable = true;
  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    prime = {
      sync.enable = false;
      offload.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
  specialisation = {
    external-display.configuration = {
      system.nixos.tags = [ "external-display" ];
      hardware.nvidia.prime.offload.enable = lib.mkForce true;
      hardware.nvidia.powerManagement.enable = lib.mkForce false;
    };
  };
  networking = {
    hostName = "dell";
    hostId = "8425e349";
  };
  systemd.network.networks."10-hw" = {
    name = "wlp59s0";
    matchConfig.Name = "wlp59s0";
    linkConfig.RequiredForOnline = "yes";
    networkConfig.DHCP = "ipv4";
    networkConfig.IPv6AcceptRA = true;
  };
  system.stateVersion = "23.05";

}
