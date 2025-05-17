{
  pkgs,
  lib,
  osConfig,
  # browser-previews,
  ...
}:
{
  # home.packages = with browser-previews.packages.${pkgs.system}; [
  #   google-chrome # Stable Release
  #   google-chrome-beta # Beta Release
  #   google-chrome-dev # Dev Release
  # ];
  home.sessionPath = [ "/etc/nixos/browsers/bin" ];
  # programs.chromium.package = (pkgs.chromium.override { enableWideVine = true; });
  programs.chromium.enable = lib.mkIf (osConfig.networking.hostName == "dell") true;
  programs.chromium.commandLineArgs = [ ];
  programs.chromium.extensions = [
    {
      id = "mlomiejdfkolichcflejclcbmpeaniij"; # https://github.com/ghostery/ghostery-extension
    }
  ];
}
