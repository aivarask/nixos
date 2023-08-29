{pkgs, ...}: {
  systemd.services."wallpaper" = {
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
    script = ''
      set -eu
      DISPLAY=:0 ${pkgs.feh}/bin/feh --bg-fill --randomize ~/.wallpaper/abstract/
    '';
  };
  systemd.timers."wallpaper" = {
    timerConfig = {
      # OnBootSec = "1h";
      OnUnitActiveSec = "1h";
      Unit = "wallpaper.service";
    };
    wantedBy = ["timers.target"];
  };
}
