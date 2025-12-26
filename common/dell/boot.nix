{ pkgs, config, ... }:
{

  boot.blacklistedKernelModules = [
    # "cirrusfb"
    # "i2c_piix4"
  ];
  boot.kernelPackages = pkgs.linuxPackages_6_12;
  boot.kernelModules = [
    "kvm-intel"
    "vhost_vsock"
  ];
  boot.kernelParams = [
    "boot.shell_on_fail"
    "loglevel=3"
  ];
  boot.extraModprobeConfig = builtins.concatStringsSep "\n" [
    "options dell-smm-hwmon ignore_dmi=1"
  ];
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.disable_ipv6" = 1;
    "net.ipv6.conf.default.disable_ipv6" = 1;
  };
  boot.initrd.availableKernelModules = [
    "rtsx_pci_sdmmc"
    "usb_storage"
  ];

}
