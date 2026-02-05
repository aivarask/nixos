{ pkgs, config, ... }:
{

  # https://wiki.nixos.org/wiki/Linux_kernel#Configuration
  boot.blacklistedKernelModules = [
    # "cirrusfb"
    # "i2c_piix4"
  ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [
    "kvm-intel"
    "wl"
    "vhost_vsock"
    "i2c-dev"
  ];
  boot.kernelParams = [
    "boot.shell_on_fail"
    "loglevel=3"
    # "module_blacklist=i915"
    # "nvidia-drm.fbdev=1"
  ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
  boot.extraModprobeConfig = builtins.concatStringsSep "\n" [
    "options dell-smm-hwmon ignore_dmi=1"
  ];
  boot.initrd.availableKernelModules = [
    "rtsx_pci_sdmmc"
    "usb_storage"
  ];
  boot.initrd.kernelModules = [ "wl" ];

}
