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
  musnix = {
    enable = true;
  };
  environment.systemPackages = with pkgs; [
    # ardour # long build fails
    libbs2b
    ladspaPlugins
    lsof
    vital
    distrho-ports
    lsp-plugins
    # bitwig-studio
    # mixxx
    yoshimi
    guitarix
    # muse # fails
    infamousPlugins
    mamba
  ];
  # https://github.com/mixxxdj/mixxx/wiki/troubleshooting
  # environment.variables.QT_AUTO_SCREEN_SCALE_FACTOR = "0";
  environment.variables.QT_FONT_DPI = config.services.xserver.dpi;
  services.udev.packages = [
    # pkgs.mixxx
    pkgs.bitwig-studio
    pkgs.vital
  ];
}
