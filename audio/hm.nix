{ config, ... }:
{
  home.file.".mixxx/controllers".source =
    config.lib.file.mkOutOfStoreSymlink "/etc/nixos/audio/controllers";

  xdg.configFile."ardour8".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/audio/ardour8";

  services.fluidsynth.enable = false;
  # services.fluidsynth.soundFont
  # services.fluidsynth.soundService = "pipewire-pulse";
  # services.fluidsynth.extraOptions = '''';
}
