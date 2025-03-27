{ lib, osConfig, ... }:
{
  # programs.chromium.package = (pkgs.chromium.override { enableWideVine = true; });
  programs.chromium.enable = lib.mkIf (osConfig.networking.hostName == "dell") true;
  programs.chromium.commandLineArgs = [ ];
  programs.chromium.extensions = [
    {
      id = "mlomiejdfkolichcflejclcbmpeaniij"; # https://github.com/ghostery/ghostery-extension
    }
  ];
  programs.chromium.initialPrefs = {
    "first_run_tabs" = [
      "https://nixos.org/"
    ];
  };
}
