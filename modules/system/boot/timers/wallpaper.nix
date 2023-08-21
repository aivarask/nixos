{
  pkgs,
  lib,
  ...
}: {
  systemd.timers."wallpaper" = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnBootSec = "1m";
      OnUnitActiveSec = "1m";
      Unit = "wallpaper.service";
    };
  };
  systemd.services."wallpaper" = {
    script = ''
      /etc/nixos/bin/wallpaper
        # set -eu
        # DISPLY=:0 ${pkgs.feh}/bin/feh --bg-fill --randomize ~/.wallpaper/*
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
}
