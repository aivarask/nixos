# vim: nofoldenable
{ pkgs, ... }:
{
  systemd.services."wallpaper" = {
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
    script = ''
      set -eu
      DISPLAY=:0 ${pkgs.feh}/bin/feh --bg-fill --randomize /etc/nixos/images/wallpaper/abstract
    '';
  };
  systemd.timers."wallpaper" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      # OnBootSec = "1h";
      OnUnitActiveSec = "1h";
      Unit = "wallpaper.service";
    };
  };
}
