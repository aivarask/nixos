{ config, ... }:
{
  home.file.".mixxx/controllers".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/audio/controllers";

  services.fluidsynth.enable = true;
  # services.fluidsynth.soundFont
  services.fluidsynth.soundService = "pipewire-pulse";
  # services.fluidsynth.extraOptions = '''';
}
