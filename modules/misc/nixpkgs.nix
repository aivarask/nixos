{lib, ...}: {
  nixpkgs.config.permittedInsecurePackages = [
    # "qtwebkit-5.212.0-alpha4"
  ];
  nixpkgs.config.joypixels.acceptLicense = true;
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "bitwig-studio"
      "unrar"
      "soulseekqt"
      "google-chrome"
      "google-chrome-dev"
      "nvidia-x11"
      "nvidia-settings"
      "joypixels"
      "spotify"
      "steam"
      "steam-original"
      "steam-run"
      "steam-runtime"
      "steamcmd"
      "ookla-speedtest"
    ];
}
