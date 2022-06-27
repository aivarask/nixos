{ config, pkgs, lib, ... }: {
  # nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.allowUnsupportedSystem = true;
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "unrar"
    "soulseekqt"
    "google-chrome"
    "google-chrome-dev"
    "nvidia-x11"
    "nvidia-settings"
    "joypixels"
    "steam"
    "steam-original"
    "steam-runtime"
    "steamcmd"
  ];
  nixpkgs.config.joypixels.acceptLicense = true;

}
