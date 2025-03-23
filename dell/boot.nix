{ }:
{
  # boot.kernelPackages = pkgs.linuxPackages_latest; # fails zfs
  boot.blacklistedKernelModules = [
    "nouveou"
    "nvidiafb"
  ];
  boot.kernelParams = [
    # "nvidia-drm.modeset=1"
  ];
  boot.kernelModules = [
    # "nvidia_drm"
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
