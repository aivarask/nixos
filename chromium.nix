{ ... }:
{
  # programs.chromium.package = (pkgs.chromium.override { enableWideVine = true; });
  programs.chromium.enable = true;
  programs.chromium.commandLineArgs = [ ];
  programs.chromium.extensions = [
    {
      id = "mlomiejdfkolichcflejclcbmpeaniij"; # https://github.com/ghostery/ghostery-extension
    }
  ];
}
