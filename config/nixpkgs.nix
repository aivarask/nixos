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
    "spotify"
    "spotify-unwrapped"
    "steam"
    "steam-original"
    "steam-runtime"
    "steamcmd"
    "ookla-speedtest"
    "viber"
  ];
  nixpkgs.config.joypixels.acceptLicense = true;

}
