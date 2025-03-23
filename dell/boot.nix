{ ... }:
{
  # boot.kernelPackages = pkgs.linuxPackages_latest; # fails zfs
  boot.blacklistedKernelModules = [
  ];
  boot.kernelParams = [
    "boot.shell_on_fail"
    # Set kernel log level to ERROR
    "loglevel=3"
  ];
  boot.kernelModules = [
    "kvm-intel"
    "vhost_vsock"
  ];

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.disable_ipv6" = 1;
    "net.ipv6.conf.default.disable_ipv6" = 1;
  };
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
