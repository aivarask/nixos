{ lib, config, ... }:
{
  services.blueman = {
    # Device B8:53:AC:C2:7F:24 Aivaras’s iPhone
    # Device AC:90:85:C6:DA:FD AirPods
    # Device D4:11:A3:98:B4:88 Galaxy A50
    enable = lib.mkDefault false;
  };
  services.caddy = {
    enable = false;
  };
  services.dnscrypt-proxy2 = {
    enable = true;
  };
  services.geoclue2 = {
    enable = lib.mkDefault true;
  };
  services.kmscon = {
    enable = lib.mkDefault true;
    autologinUser = lib.mkDefault "root";
    useXkbConfig = true;

    hwRender = lib.mkDefault true;
    extraConfig = ''
      font-size=${if config.networking.hostName == "dell" then "10" else "6"}
      font-dpi=${toString config.services.xserver.dpi}
    '';
  };
  services.libinput = {
    mouse = {
      accelSpeed = "+0.5";
    };
    touchpad = {
      naturalScrolling = true;
      accelSpeed = "+0.5";
    };
  };
  services.locate = {
    enable = true;
  };
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      X11Forwarding = true;
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "yes";
    };
  };
  services.pipewire = {
    enable = false;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };
  services.redshift = {
    enable = true;
    temperature = {
      day = 6500; # 5500
      night = 4500; # 3700
    };
  };
  networking.firewall.allowedTCPPorts = [
    9091
    51413
  ];
  services.transmission = {
    enable = false;
    settings = {
      watch-dir = "/var/lib/transmission/watch-dir";
      watch-dir-enabled = true;
    };
  };
  services.unclutter = {
    enable = true;
    timeout = 1;
    extraOptions = [
      # "noevents"
      # "grab"
      # "fork"
    ];
  };

}
