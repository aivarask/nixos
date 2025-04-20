{ pkgs3, inputs, ... }:
{
  environment.systemPackages = [
    pkgs3.nps # https://github.com/OleMussmann/nps
  ];
  systemd.timers."refresh-nps-cache" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "5m"; # daily
      Persistent = true;
      Unit = "refresh-nps-cache.service";
    };
  };

  systemd.services."refresh-nps-cache" = {
    # Make sure `nix` and `nix-env` are findable by systemd.services.
    path = [ "/run/current-system/sw/" ];
    serviceConfig = {
      Type = "oneshot";
      User = "REPLACE_ME"; # ⚠️ replace with your "username" or "${user}", if it's defined
    };
    script = ''
      set -eu
      echo "Start refreshing nps cache..."
      ${pkgs3.nps}/bin/nps -dddd -e -r
      echo "... finished nps cache with exit code $?."
    '';
  };
}
