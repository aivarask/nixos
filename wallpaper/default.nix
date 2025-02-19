{ pkgs, ... }:
{
  systemd.user.services."wallpaper" = {
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
    environment = {
      DISPLAY = ":0";
    };
    script = ''
      set -eu
      ${pkgs.feh}/bin/feh --bg-fill --randomize /etc/nixos/wallpaper/bluemoon
    '';
    startAt = "*:0/5";
  };
  # systemd.timers."wallpaper" = {
  #   wantedBy = [ "timers.target" ];
  #   timerConfig = {
  #     # OnBootSec = "1h";
  #     OnUnitActiveSec = "1h";
  #     Unit = "wallpaper.service";
  #   };
  # };
}
