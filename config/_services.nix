# vim:foldlevel=4
{
  pkgs,
  lib,
  config,
  ...
}:
{
  services.caddy = {
    enable = false;
  };
  services.geoclue2 = {
    enable = true;
  };
  services.kmscon = {
    enable = lib.mkDefault true;
    autologinUser = lib.mkDefault "root";
    useXkbConfig = true;
    hwRender = lib.mkDefault true;
    extraConfig = ''
      font-dpi=${toString config.services.xserver.dpi}
      font-size=${if config.networking.hostName == "dell" then "10" else "12"}
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
  services.redshift = {
    enable = true;
    temperature.day = 6500;
    temperature.night = 5500;
  };
  services.transmission = {
    enable = true;
    openPeerPorts = true;
    settings = {
      watch-dir = "/var/lib/transmission/watch-dir";
      watch-dir-enabled = true;
    };
  };
  services.unclutter = {
    # unclutter-xfixes
    enable = false;
    timeout = 1;
    extraOptions = [
      # "noevents"
      # "grab"
      # "fork"
    ];
  };

  services.maddy = {
    enable = true;
    primaryDomain = "localhost";
    ensureAccounts = [
      "test@localhost"
      "ab@localhost"
      "test@test.ekolangas.lt"
    ];
    ensureCredentials = {
      "test@localhost".passwordFile = "${pkgs.writeText "postmaster" "l"}";
      "ab@localhost".passwordFile = "${pkgs.writeText "postmaster" "l"}";
      "test@test.ekolangas.lt".passwordFile = "${pkgs.writeText "postmaster" "l"}";
    };
  };

}
