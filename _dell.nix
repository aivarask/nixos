# DELL XPS 7590
{
  config,
  lib,
  modulesPath,
  pkgs,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "sd_mod"
      "rtsx_pci_sdmmc"
      "usb_storage" # added ssd
    ];
    initrd.kernelModules = [];
    kernelModules = ["kvm-intel"];
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
      device = "/dev/disk/by-uuid/CFAB-7FF4";
      fsType = "vfat";
    };
  };

  swapDevices = [];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    bluetooth.enable = true;
  };
  system.stateVersion = "23.05";
  console.font = lib.mkForce "${pkgs.terminus_font}/share/consolefonts/ter-v32n.psf.gz";
  environment.variables = {
    MOZ_USE_XINPUT2 = "1";
  };

  # https://nixos.wiki/wiki/Systemd-networkd
  # /etc/nixos/modules/system/boot/networkd.nix

  systemd.network.networks."10-hw" = {
    name = "wlp59s0";
    matchConfig.Name = "wlp59s0";
    linkConfig.RequiredForOnline = "yes";
    networkConfig = {
      DHCP = "ipv4";
      IPv6AcceptRA = false;
    };
  };

  networking = {
    hostName = "dell";
    hostId = "8425e349";
  };

  location.provider = "geoclue2";
  services = {
    blueman.enable = true;
    kmscon = {
      extraConfig = ''
        font-size=12
        font-dpi=288
      '';
    };

    geoclue2.enable = true;

    xserver = {
      imwheel.enable = false;
      # synaptics.enable = true;
      # synaptics.accelFactor = "";
      synaptics.minSpeed = "0.7";
      dpi = 168; # 96*1.75
      libinput = {
        enable = true;
        touchpad = {
          # accelProfile = "flat";
          naturalScrolling = true;
          accelSpeed = "+7";
        };
      };
    };
  };
  # services.xserver.displayManager.sddm.enable = true;
  # networking.wireless.enable = false;
  # networking.networkmanager.enable = true;
  # services.xserver.displayManager.autoLogin.enable = true;
  # services.xserver.displayManager.autoLogin.user = "root";
}
