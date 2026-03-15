{
  lib,
  config,
  pkgs,
  ...
}:
{
  boot.supportedFilesystems.nfs = true;
  boot.supportedFilesystems.zfs = lib.mkForce false;
  boot.tmp.cleanOnBoot = true;
  boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.systemd-boot.enable = lib.mkDefault true;
  boot.loader.systemd-boot.netbootxyz.enable = true;
  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 100001;
    "fs.inotify.max_queued_events" = 100001;
  };

  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "boot.shell_on_fail"
    "loglevel=3"
  ];
  boot.kernelModules = [
    "vhost_vsock"
    "kvm-intel"
    "kvm-amd"
    "i2c-dev"
    "ddcci-backlight"
  ];
  boot.extraModulePackages = [
    config.boot.kernelPackages.ddcci-driver
  ];
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];
}
