{
  pkgs,
  inputs,
  lib,
  ...
}:
let

in
{
  imports = [
  ];
  nixpkgs.overlays = with inputs; [
    (final: prev: {
      aiv.nps = inputs.nps.packages.${prev.system}.default;
    })
  ];
  environment.systemPackages = [
    pkgs.aiv.nps # https://github.com/OleMussmann/nps
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
      ${pkgs.aiv.nps}/bin/nps -dddd -e -r
      echo "... finished nps cache with exit code $?."
    '';
  };
}
