# vim: foldlevel=3 nofoldenable
# B450 AORUS M
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
    ./pc.route.nix
  ];
  boot.kernelPackages = pkgs.linuxPackages_6_1;
  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];
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
      device = "/dev/disk/by-uuid/CE3C-0926";
      fsType = "vfat";
    };
  };
  swapDevices = [ ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    fancontrol = {
      enable = false;
      config = '''';
    };
  };
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    # powerManagement.finegrained = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  system.stateVersion = "23.05";
  networking = {
    enableIPv6 = false;
    hostName = "pc";
    hostId = "007f0200";
    wireless.enable = true;
    wireless.driver = "wext"; # "TP-Link TL-WN881 ND"
    interfaces.eno1.wakeOnLan.enable = true;
  };
  systemd.network.networks."20-wlp6s0" = {
    name = "wlp6s0";
    matchConfig.Name = "wlp6s0";
    linkConfig.RequiredForOnline = "yes";
    networkConfig = {
      DHCP = "ipv4";
      IPv6AcceptRA = true;
    };
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
  environment.variables.LIBVA_DRIVER_NAME = "vdpau";
  environment.systemPackages = with pkgs; [ libva-utils ];

}
