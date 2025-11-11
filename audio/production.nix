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
    # bitwig-studio
    mixxx
    vital
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

        # distrho-ports.override
        # {
        #   plugins = [
        #     "vitalium"
        #     "swankyamp"
        #     "dexed"
        #   ];
        # }
        distrho-ports
        # ladspaPlugins
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

        # https://linuxsynths.com/
        # https://x42-plugins.com/x42
        # https://kx.studio/Repositories:Plugins#adlplug
        # mod-arpeggiator-lv2
        # qmidiarp
        # adlplug
        # AMB-plugins
        # artyFX
        # bchoppr
        # bjumblr
        # bsequencer
        # bshapr
        # bslizr
        # calf

      ]
    ))
    (lib.mkIf false (
      with pkgs;
      [
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
      ]
    ))
  ];
}
