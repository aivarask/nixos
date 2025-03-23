{
  config,
  lib,
  modulesPath,
  pkgs,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./binarycache.nix
    ./boot.nix
    ./gpu.nix
    ./kmscon.nix
    ./network.nix
    ./qt.nix
  ];
  environment.systemPackages = with pkgs; [
    # lshw
    # mesa-demos # glxinfo glxgears
    # nvidia-vaapi-driver
    libva-utils # vainfo
    intel-gpu-tools # intel_gpu_top
    nvtopPackages.nvidia # nvtop
    nvtopPackages.intel
    # vdpauinfo # vdpauinfo
    # libvdpau
    # libvdpau-va-gl
    # vulkan-tools # vulkaninfo
    # clinfo # clinfo
  ];
  services.xserver.dpi = 283;
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
  swapDevices = [

  ];

  system.stateVersion = "23.05";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  services.switcherooControl.enable = true;

}
