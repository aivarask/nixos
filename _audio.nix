{ pkgs
, ...
}: {
  # https://nixos.wiki/wiki/Audio_production
  # https://github.com/musnix/musnix
  # musnix.enable = true;
  environment.systemPackages = with pkgs; [
    # https://github.com/NixOS/nixpkgs/blob/d65bceaee0fb1e64363f7871bc43dc1c6ecad99f/pkgs/applications/audio/vital/default.nix#L59
    # https://vital.audio/
    libbs2b
    ladspaPlugins
    vital
    bitwig-studio
    mixxx
  ];
  environment.variables = {
    QT_AUTO_SCREEN_SCALE_FACTOR = "0"; # https://github.com/mixxxdj/mixxx/wiki/troubleshooting
  };
  services.udev.packages = [
    pkgs.mixxx
    pkgs.bitwig-studio
    # pkgs.android-udev-rules
  ];
}
