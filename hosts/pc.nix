{...}: {
  imports = [
    ./_common.nix
    ./pc-hardware.nix
  ];
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
    xserver = {
      dpi = 144;
      imwheel = {
        enable = true;
        rules = {
          "^(telegram-desktop|chromium|brave|firefox).*" = ''
            None, Up, Button4, 2
            None, Down, Button5, 2
            Shift_L,   Up,   Shift_L|Button4, 2
            Shift_L,   Down, Shift_L|Button5, 2
            Control_L, Up,   Control_L|Button4
            Control_L, Down, Control_L|Button5
          '';
        };
      };
    };

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
