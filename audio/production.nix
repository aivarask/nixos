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
    # nix-locate vst3
    zam-plugins
    ysfx

    #
    mixxx # https://github.com/mixxxdj/mixxx/wiki/troubleshooting

    # ardour # long build fails
    libbs2b
    ladspaPlugins
    lsof
    vital
    distrho-ports
    yoshimi
    guitarix
    # muse # fails
    infamousPlugins
    mamba

    bitwig-studio
    renoise
    reaper
    # zrythm
    # ardour
    lmms
    # rosegarden
    qtractor

  ];
}
