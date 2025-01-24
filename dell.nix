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

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  powerManagement = {
    powertop.enable = true;
    # cpuFreqGovernor = "ondemand";
  };

  # /run/opengl-driver/lib/dri
  environment.variables.LIBVA_DRIVER_NAME = "nvidia";
  # /run/opengl-driver/lib/vdpau
  environment.variables.VDPAU_DRIVER = "nvidia";
  # stat /dev/dri/*
  environment.variables.MOZ_DRM_DEVICE = "/dev/dri/by-path/pci-0000:01:00.0-card";
  # environment.variables.LIBVA_DRIVER_NAME = "nvidia";
  # environment.variables.VDPAU_DRIVER = "nvidia";
  environment.variables.VAAPI_DEVICE = "/dev/dri/by-path/pci-0000:01:00.0-card";
  environment.variables.MOZ_DISABLE_RDD_SANDBOX = 1;
  environment.variables.NVD_BACKEND = "direct";
  # (https://unix.stackexchange.com/a/596888)
  # https://wiki.archlinux.org/title/HiDPI#GDK_3_(GTK_3)

  environment.systemPackages = with pkgs; [
    #
    lshw
    mesa-demos # glxinfo glxgears
    libva-utils # vainfo
    intel-gpu-tools # intel_gpu_top
    nvtopPackages.nvidia # nvtop
    nvtopPackages.intel
    vdpauinfo # vdpauinfo
    libvdpau
    libvdpau-va-gl
    vulkan-tools # vulkaninfo
    clinfo # clinfo
  ];
  services.blueman.enable = true;
  services.switcherooControl.enable = true;
  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
  networking.hostName = "dell";
  networking.hostId = "8425e349";

  systemd.network.networks."10-hw" = {
    name = "wlp59s0";
    matchConfig.Name = "wlp59s0";
    linkConfig.RequiredForOnline = "yes";
    networkConfig.DHCP = "ipv4";
    networkConfig.IPv6AcceptRA = true;
  };
  system.stateVersion = "23.05";

  # Virtualization
  # https://wiki.nixos.org/wiki/Virt-manager
  # virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
  };

  users.users.nixosvmtest.isSystemUser = true;
  users.users.nixosvmtest.initialPassword = "test";
  users.users.nixosvmtest.group = "nixosvmtest";
  users.groups.nixosvmtest = { };
  virtualisation.vmVariant = {
    # nixos-rebuild build-vm
    virtualisation = {
      memorySize = 2048;
      cores = 3;
    };
  };

}
