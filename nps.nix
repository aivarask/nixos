{
  pkgs,
  inputs,
  lib,
  ...
}:
let

in
{
  imports = [ ];
  nixpkgs.overlays = with inputs; [
    (final: prev: { aiv.nps = inputs.nps.packages.${prev.system}.default; })
  ];
  environment.systemPackages = [
    pkgs.aiv.nps # https://github.com/OleMussmann/nps
  ];
  systemd.timers."refresh-nps-cache" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
      Unit = "refresh-nps-cache.service";
    };
  };

  systemd.services."refresh-nps-cache" = {
    path = [ "/run/current-system/sw/" ]; # Make sure `nix` and `nix-env` are findable by systemd.services.
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
    script = ''
      set -eu
      echo "Start refreshing nps cache..."
      ${pkgs.aiv.nps}/bin/nps -dddd -e -r
      echo "... finished nps cache with exit code $?."
    '';
  };
}
