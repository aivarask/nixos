{ pkgs, ... }: {
  imports = [
    ./common.nix
    ./pc-hardware.nix
    ./_networking.nix
  ];
  system.stateVersion = "23.05";
  services.kmscon = {
    extraConfig = ''
      font-size=12
      font-dpi=72
    '';
  };

  networking = {
    hostName = "pc";
    hostId = "007f0200";
    useDHCP = false;
    interfaces = {
      eno1.useDHCP = true;
      wlp6s0.useDHCP = true;
      wlp6s0.ipv4.addresses = [
        {
          address = "192.168.1.111";
          prefixLength = 24;
        }
      ];
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
      dpi = 144; # 96*1.5
      imwheel = {
        enable = true;
        rules = {
          "^(firefox|brave-browser|google-chrome-stable|google-chrome|telegram-desktop)$" = ''
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
