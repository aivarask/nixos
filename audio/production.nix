{
  pkgs,
  config,
  inputs,
  ...
}:
{
  # https://wiki.nixos.org/wiki/Audio_production
  # https://github.com/musnix/musnix
  imports = [
    inputs.musnix.nixosModules.musnix
  ];
  musnix.enable = true;
  services.udev.packages = [
    pkgs.mixxx
    pkgs.bitwig-studio
    pkgs.vital
  ];

  environment.pathsToLink = [
    "/share/mixxx"
    "/doc/share"
  ];
  environment.systemPackages = with pkgs; [
    roomeqwizard
    # synth
    zynaddsubfx
    zynaddsubfx-ntk
    vaporizer2

    bc
    calc
    # MIDI monitoring
    lilypond
    # midivisualizer # fails
    vkeybd

    # nix-locate vst3
    ysfx

    mixxx # https://github.com/mixxxdj/mixxx/wiki/troubleshooting

    libbs2b
    ladspaPlugins
    lsof
    distrho-ports
    yoshimi
    guitarix
    # muse # fails
    # infamousPlugins # build fails
    mamba

    # MIDI
    # rosegarden

    # DAW
    ardour
    # lmms # fails
    # bitwig-studio
    # renoise
    # reaper
    # zrythm
    # qtractor

    # Sampler
    # drumkv1

    # VST plugins
    # zam-plugins
    # tunefish
    # helm
    # vital
    surge
    # surge-XT # fails
    # decent-sampler
    # odin2
  ];
}
