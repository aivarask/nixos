{ ... }:
{
  # boot.kernelPackages = pkgs.linuxPackages_latest; # fails zfs
  boot.blacklistedKernelModules = [
  ];
  boot.kernelParams = [
  ];
  boot.kernelModules = [
    "kvm-intel"
  ];
  boot.extraModulePackages = [ ];
  boot.initrd.kernelModules = [ ];
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "sd_mod"
    "rtsx_pci_sdmmc"
    "usb_storage"
  ];
}
