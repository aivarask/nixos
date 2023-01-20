{ config, lib, pkgs, modulesPath, ... }: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    initrd.availableKernelModules =
      [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-amd" ];
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
      device = "/dev/disk/by-uuid/32F7-914D";
      # device = "/dev/disk/by-uuid/9B3A-B4F1";
      fsType = "vfat";
    };
  };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  environment.variables = { LIBVA_DRIVER_NAME = "nvidia"; };
  hardware = {
    cpu.amd.updateMicrocode =
      lib.mkDefault config.hardware.enableRedistributableFirmware;
    opengl = {
      enable = true;
      extraPackages = with pkgs;
        [
          # vaapiIntel # LIBVA_DRIVER_NAME=i965
          # vaapiVdpau
          # libvdpau-va-gl
        ];
    };
    # video.hidpi.enable = lib.mkDefault true;
    nvidia = { modesetting.enable = true; };
    nvidia.powerManagement.enable = true;
    # nvidia.powerManagement.finegrained = true;
  };
}
