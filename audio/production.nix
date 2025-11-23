{
  pkgs,
  config,
  inputs,
  lib,
  ...
}:
{
  # https://wiki.nixos.org/wiki/Audio_production
  # https://github.com/musnix/musnix
  imports = [
    inputs.musnix.nixosModules.musnix
  ];
  musnix.enable = true;
  services.udev.packages = with pkgs; [
    ardour
    mixxx
    # vital
    audacity
  ];

  environment.pathsToLink = [
    "/share/mixxx"
    "/doc/share"
  ];
  environment.systemPackages = lib.mkMerge [
    (lib.mkIf true (
      with pkgs;
      [
        ardour
        hydrogen
        distrho-ports
        lsp-plugins
        x42-plugins

        # drum
        x42-avldrums
        drumgizmo
        geonkick

        # synth
        cardinal
        odin2
        surge

      ]
    ))

  ];
}
