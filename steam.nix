{pkgs, ...}: {
  programs.steam.enable = false;
  environment.systemPackages = with pkgs; [
    # steam
    # steam-run
    # steam-tui
    # steamPackages.steam
  ];
}
