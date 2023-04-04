{ ... }: {
  imports = [
    ./_networking.nix
    ./dell-hardware.nix
  ];
  system.stateVersion = "23.05";

  networking = {
    hostName = "dell";
    hostId = "8425e349";
    useDHCP = false;
    interfaces.wlp59s0.useDHCP = true;
    interfaces.wlp59s0.ipv4.addresses = [
      {
        address = "192.168.1.112";
        prefixLength = 24;
      }
    ];
    defaultGateway = "192.168.1.1";
  };

  location.provider = "geoclue2";

  services.geoclue2.enable = true;
  services = {
    xserver = {
      dpi = 168; # 96*1.75
      libinput = {
        enable = true;
        touchpad.naturalScrolling = true;
      };
    };
  };
}
