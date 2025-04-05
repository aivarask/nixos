{ lib, osConfig, ... }:
{
  # HM
  # programs.chromium.package = (pkgs.chromium.override { enableWideVine = true; });
  programs.chromium.enable = lib.mkIf (osConfig.networking.hostName == "dell") true;
  programs.chromium.commandLineArgs = [ ];
  programs.chromium.extensions = [
    {
      id = "mlomiejdfkolichcflejclcbmpeaniij"; # https://github.com/ghostery/ghostery-extension
    }
  ];
  # https://discourse.nixos.org/t/link-scripts-to-bin-home-manager/41774/3
  home.sessionPath = [ "/etc/nixos/browsers/bin" ];
  # programs.chromium.initialPrefs = lib.mkIf {
  #   "first_run_tabs" = [
  #     "https://nixos.org/"
  #   ];
  # };
}
