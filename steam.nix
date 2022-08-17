{ config, pkgs, ... }: {
  programs.steam.enable = true;
  environment.systemPackages = with pkgs; [
    # steam
    # steam-run
    # steam-tui
    # steamPackages.steam
  ];
}

