{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./_common.nix
    ./dell-hardware.nix
  ];
  system.stateVersion = "23.05";
  console.font = lib.mkForce "${pkgs.terminus_font}/share/consolefonts/ter-v32n.psf.gz";
  environment.variables = {
    MOZ_USE_XINPUT2 = "1";
  };

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
  services = {
    blueman.enable = true;
    # Device B8:53:AC:C2:7F:24 Aivaras’s iPhone
    # Device AC:90:85:C6:DA:FD AirPods
    # Device D4:11:A3:98:B4:88 Galaxy A50
    kmscon = {
      extraConfig = ''
        font-size=12
        font-dpi=288
      '';
    };

    geoclue2.enable = true;

    xserver = {
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
}
