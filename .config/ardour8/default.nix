{
  pkgs,
  config,
  inputs,
  lib,
  ...
}:
{
  # https://wiki.nixos.org/wiki/Audio_production
  # https://plugins4free.com/instruments/
  # https://linuxmusic.rocks/
  # https://linuxmusicians.com/viewtopic.php?t=26947
  imports = [
    inputs.musnix.nixosModules.musnix # https://github.com/musnix/musnix
  ];
  # musnix.enable = true;
  musnix.kernel.packages = pkgs.linuxPackages_latest_rt;
  services.udev.packages = with pkgs; [
    ardour
    mixxx
  ];

  environment.pathsToLink = [
    # "/share/mixxx"
    # "/doc/share"
  ];
  environment.systemPackages = lib.mkMerge [
    (lib.mkIf true (
      with pkgs;
      [
        # acoustics
        roomeqwizard

        # https://wiki.archlinux.org/title/Convert_FLAC_to_MP3
        flac2all
        calf

        #
        ardour
        hydrogen
        distrho-ports
        lsp-plugins
        x42-plugins
        mda_lv2

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
