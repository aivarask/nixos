{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "usbhid"
      "usb_storage" # added ssd
      "sd_mod" # ?
    ];
    initrd.kernelModules = [];
    kernelModules = ["kvm-amd"];
    extraModulePackages = [];
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
      fsType = "vfat";
    };
  };

  swapDevices = [];

  hardware = {
    cpu.amd.updateMicrocode =
      lib.mkDefault config.hardware.enableRedistributableFirmware;
    fancontrol = {
      enable = false;
      config = ''
      '';
    };
  };
  system.stateVersion = "23.05";
  environment.variables = {
    LIBVA_DRIVER_NAME = "vdpau";
  };
  services.kmscon = {
    extraConfig = ''
      font-size=12
      font-dpi=72
    '';
  };

  networking = {
    hostName = "pc";
    hostId = "007f0200";
    useDHCP = true;
    interfaces = {
      eno1 = {
        wakeOnLan.enable = true;
        useDHCP = true;
        ipv4.addresses = [
          {
            address = "192.168.1.110";
            prefixLength = 24;
          }
        ];
      };
      wlp6s0 = {
        useDHCP = true;
        ipv4.addresses = [
          {
            address = "192.168.1.111";
            prefixLength = 24;
          }
        ];
      };
    };
    wireless.driver = "wext"; # "TP-Link TL-WN881 ND"
    defaultGateway = "192.168.1.1";
  };
  location = {
    provider = "manual";
    latitude = 54.0;
    longitude = 25.0;
  };
  services = {
    nginx.virtualHosts."live.fixasparts.com" = {
      forceSSL = false;
      enableACME = false;
      locations."/" = {
        proxyPass = "https://127.0.0.1:4173";
        proxyWebsockets = true;
        extraConfig = ''
        '';
      };
    };
  };
}
