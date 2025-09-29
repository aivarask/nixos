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
    bc
    calc
    # MIDI monitoring
    lilypond
    midivisualizer
    vkeybd

    # nix-locate vst3
    ysfx

    mixxx # https://github.com/mixxxdj/mixxx/wiki/troubleshooting

    # ardour # long build fails
    libbs2b
    ladspaPlugins
    lsof
    distrho-ports
    yoshimi
    guitarix
    # muse # fails
    infamousPlugins
    mamba

    # MIDI
    # rosegarden

    # DAW
    bitwig-studio
    renoise
    reaper
    # zrythm
    # ardour
    lmms # gtk2
    qtractor

    # Sampler
    drumkv1

    # VST plugins
    zam-plugins
    # tunefish
    helm
    vital
    surge
    surge-XT
    decent-sampler
    odin2

  ];
}
