{
  pkgs,
  lib,
  ...
}: {
  systemd.timers."wallpaper" = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnBootSec = "5m";
      OnUnitActiveSec = "5m";
      Unit = "wallpaper.service";
    };
  };
  systemd.services."wallpaper" = {
    script = ''
      set -eu
      ${pkgs.feh} --bg-fill --randomize ~/.wallpaper/*
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
}
