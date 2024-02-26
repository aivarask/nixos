{ config, lib, modulesPath, pkgs, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot = {
    initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
  };
  fileSystems = {
    "/" = { device = "zroot/root/nixos"; fsType = "zfs"; };
    "/home" = { device = "zroot/home"; fsType = "zfs"; };
    "/boot" = { device = "/dev/disk/by-uuid/CE3C-0926"; fsType = "vfat"; };
  };
  swapDevices = [ ];
  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    fancontrol = {
      enable = false;
      config = '' '';
    };
  };
  system.stateVersion = "23.05";
  environment.systemPackages = with pkgs; [ libva-utils ];
  environment.variables = {
    LIBVA_DRIVER_NAME = "vdpau";
  };

  systemd.network.networks."10-eno1" = {
    name = "eno1";
    matchConfig.Name = "eno1";
    # linkConfig.RequiredForOnline = "yes"; # or routable
    networkConfig = {
      DHCP = "ipv4";
      IPv6AcceptRA = true;

    };
  };

  systemd.network.networks."20-wlp6s0" = {
    name = "wlp6s0";
    matchConfig.Name = "wlp6s0";
    # linkConfig.RequiredForOnline = "no";
    networkConfig = {
      DHCP = "ipv4";
      IPv6AcceptRA = true;
    };
  };

  networking = {
    hostName = "pc";
    hostId = "007f0200";
    wireless.enable = true;
    wireless.driver = "wext"; # "TP-Link TL-WN881 ND"
    interfaces.eno1.wakeOnLan.enable = true;
  };
  location = {
    provider = "manual";
    latitude = 54.0;
    longitude = 25.0;
  };
}
