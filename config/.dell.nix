# vim: foldlevel=4
{
  pkgs,
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
  # https://www.youtube.com/watch?v=qlfm3MEbqYA&t=256s
  # https://wiki.archlinux.org/title/Hardware_video_acceleration
  # https://wiki.archlinux.org/title/Firefox
  environment.variables.LIBVA_DRIVER_NAME = "nvidia";
  environment.variables.VDPAU_DRIVER = "nvidia";
  environment.variables.VAAPI_DEVICE = "/dev/dri/by-path/pci-0000:01:00.0-render";
  environment.variables.MOZ_DISABLE_RDD_SANDBOX = 1;
  environment.variables.NVD_BACKEND = "direct";
  environment.systemPackages = with pkgs; [
    lshw
    mesa-demos # glxinfo glxgears
    libva-utils # vainfo
    # nvtopPackages.intel
    nvtopPackages.nvidia
    vdpauinfo
  ];
  # hardware.graphics.enable32Bit = true;
  services.switcherooControl.enable = true;
  # hardware.nvidia = {
  #   powerManagement.enable = false;
  #   powerManagement.finegrained = false;
  # };

  # https://wiki.nixos.org/wiki/NVIDIA
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
  # hardware.nvidia.prime.reverseSync.enable = true;
  # hardware.nvidia.prime = {
  #   offload = {
  #     enable = false;
  #     enableOffloadCmd = false;
  #   };
  #   sync.enable = true;
  # };

  # specialisation = {
  #   external-display.configuration = {
  #     system.nixos.tags = [ "external-display" ];
  #     hardware.nvidia.prime.offload.enable = lib.mkForce true;
  #     hardware.nvidia.powerManagement.enable = lib.mkForce false;
  #   };
  # };
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
