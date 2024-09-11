{ lib, ... }:
{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      # audio
      "vital"
      "vital-1.5.5"
      "bitwig-studio"
      # --
      "unrar"
      "soulseekqt"
      "google-chrome"
      "google-chrome-dev"
      "nvidia-x11"
      "nvidia-settings"
      "ookla-speedtest"
      "vscode"
      "intelephense"
    ];
}
