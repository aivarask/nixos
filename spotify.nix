{
  system =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        ncspot
        spotify
        spotifyd
        spotify-qt
        spotdl
      ];

      # https://docs.spotifyd.rs
      # https://github.com/Spotifyd/spotifyd/issues
      services.spotifyd.enable = true;
      services.spotifyd.settings = {
        global = {
          backend = "pipe";
          device_type = "computer";
          use_mpris = false;
          # bitrate = 320;
          dbus_type = "system";
        };
      };
      # services.playerctld.enable = true;

      systemd.tmpfiles.settings."10-spotifyd" = {
        "/root/.config/spotifyd/spotifyd.conf" = {
          "L+" = {
            user = "root";
            group = "root";
            mode = "0777";
            type = "L+";
            argument = "/etc/nixos/spotifyd.conf";
          };
        };
      };
    };
}
