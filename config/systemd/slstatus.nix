{ pkgs, ... }: {
  systemd.timers."slstatus" = {
    enable = false;
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnActiveSec = "3";
      # OnBootSec = "10";
      # OnStartupSec = "5";
      OnUnitActiveSec = "1h";
      Unit = "slstatus.service";
      Persistent = true;
    };
  };
  systemd.services."slstatus" = {
    script = ''
      set -eu
      ${pkgs.dig}/bin/dig -4 TXT +short o-o.myaddr.l.google.com @ns1.google.com > /tmp/ip
      # ${pkgs.dig}/bin/dig +short myip.opendns.com @resolver1.opendns.com > /tmp/ip
      ${pkgs.curl}/bin/curl -s wttr.in/Vilnius?format=2 > /tmp/wttr
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
}
