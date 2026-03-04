# B450 AORUS M
{
  config,
  lib,
  modulesPath,
  pkgs,
  inputs,
  ...
}:
{
  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXROOT";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/NIXBOOT";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };
  swapDevices = [ ];
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    # "https://github.com/NixOS/nixos-hardware/tree/master/common/gpu/nvidia"
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
  ];
  networking.hostName = "pc";
  system.stateVersion = "25.05";
  nixpkgs.hostPlatform = "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.fancontrol.enable = false;
  hardware.fancontrol.config = "";

  # https://nouveau.freedesktop.org/CodeNames.html
  # https://github.com/korvahannu/arch-nvidia-drivers-installation-guide
  # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
  # https://discourse.nixos.org/t/nvidia-sync-nvidia-smi/33960
  # https://discourse.nixos.org/t/nvidia-open-breaks-hardware-acceleration/58770
  # https://discourse.nixos.org/search?q=RTX+2060+drivers

  boot.kernelModules = [
    "kvm-amd"
    "vhost_vsock"
    "i2c-dev"
    "ddcci-backlight"
  ];
  boot.kernelParams = [
    "boot.shell_on_fail"
    "loglevel=3"
  ];

  services.udev.extraRules =
    # udevadm
    let
      bash = "${pkgs.bash}/bin/bash";
      # cat /sys/bus/i2c/devices/i2c-17/name
      # ddcutil setvcp 10 70
      ddcciDev = "nvkm-0000:06:00.0-aux-0009";
      ddcciNode = "/sys/bus/i2c/devices/i2c-17/new_device";
    in
    ''
      SUBSYSTEM=="i2c", ACTION=="add", ATTR{name}=="${ddcciDev}", RUN+="${bash} -c 'sleep 30; printf ddcci\ 0x37 > ${ddcciNode}'"
    '';

  boot.blacklistedKernelModules = [ ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.extraModulePackages = [ config.boot.kernelPackages.ddcci-driver ];
  # boot.initrd.kernelModules = [ "nvidia" ];
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
