{ pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_6_12;
  boot.kernelModules = [
    "kvm-amd"
    "vhost_vsock"
  ];
  boot.kernelParams = [
    "boot.shell_on_fail"
    "loglevel=3"
  ];
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
}
