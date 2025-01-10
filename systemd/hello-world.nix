# vim: nofoldenable
{ pkgs, ... }:
{
  services.systembus-notify.enable = true;
  systemd.services."hello-world" = {
    script = ''
      ${pkgs.libnotify}/bin/notify-send "Hello World"
      # set -eu
      # ${pkgs.coreutils}/bin/echo "Hello World"
    '';
    environment = {
      DISPLAY = ":0";
    };
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
    startAt = "*:0/5";
  };
  # systemd.timers."hello-world" = {
  #   description = ''
  #     Simple greeting timer for testing purposes.
  #   '';
  #   wantedBy = [ "timers.target" ];
  #   timerConfig = {
  #     OnBootSec = "5m";
  #     OnUnitActiveSec = "5m";
  #     Unit = "hello-world.service";
  #   };
  # };
}
