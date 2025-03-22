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
    ./dell-gpu.nix
    ./dell-linux.nix
    ./bitwarden.nix
  ];
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
  swapDevices = [

  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  services.switcherooControl.enable = true;
  # For GeForce GTX 1650 nvidia.com recommends 550 version (stable), but 570 (beta) returns from suspend
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
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

  services.nix-serve = {
    enable = true;
    secretKeyFile = "/var/cache-priv-key.pem";
  };
  networking.firewall.allowedTCPPorts = [
    80
  ];
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts = {
      "binarycache.dell.local" = {
        locations."/".proxyPass =
          "http://${config.services.nix-serve.bindAddress}:${toString config.services.nix-serve.port}";
      };
    };
  };

}
