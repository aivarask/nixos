# vim: nofoldenable
{ pkgs, ... }:
{
  systemd.services."hello-world" = {
    script = ''
      set -eu
      ${pkgs.coreutils}/bin/echo "Hello World"
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
  systemd.timers."hello-world" = {
    description = ''
      Simple greeting timer for testing purposes.
    '';
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5m";
      OnUnitActiveSec = "5m";
      Unit = "hello-world.service";
    };
  };
}
