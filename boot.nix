{
  lib,
  config,
  pkgs,
  ...
}:
{
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

  boot.kernelParams = [
    "boot.shell_on_fail"
    "loglevel=3"
  ];
  boot.kernelModules = [
    "vhost_vsock"
    "kvm-intel"
    "kvm-amd"
    "wl"
    "i2c-dev"
    "ddcci-backlight"
  ];
  boot.extraModulePackages = [
    config.boot.kernelPackages.broadcom_sta
    config.boot.kernelPackages.ddcci-driver
  ];
  boot.initrd.kernelModules = [ "wl" ];
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "broadcom-sta-6.30.223.271-59-6.18.15"
    "broadcom-sta-6.30.223.271-59-6.18.16"
    "broadcom-sta-6.30.223.271-59-6.19.5"
    "broadcom-sta-6.30.223.271-59-6.19.6"

  ];
}
