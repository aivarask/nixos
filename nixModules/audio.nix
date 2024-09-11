{ pkgs, ... }:
{
  # musnix.enable = true;
  environment.systemPackages = with pkgs; [
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
