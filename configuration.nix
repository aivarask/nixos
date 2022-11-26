{ config, pkgs, lib, ... }: {
  imports = [
    ./config/boot.nix
    ./config/console.nix
    ./config/fonts.nix
    ./config/location.nix
    ./config/nix.nix
    ./config/nixpkgs.nix
    ./config/powerManagement.nix
    ./config/programs.nix
    ./config/services.nix
    ./xserver.nix
    ./mysql
    ./systemd.nix
    ./config/cron.nix
    ./config/users.nix
    ./config/virtualisation.nix
    ./config/mpd.nix
    # ./config/pipeWire.nix
    ./config/tmux.nix
    ./security.nix
    ./networking.nix
    ./nginx
    ./environment.nix
    ./LF_ICONS.nix
    ./systemPackages.nix
    ./xdg.nix
    # ./nicotine.nix
  ];

  # moz-extension://cd54c47b-5f75-4660-a7fb-767b63a96a36/home.html#initialize/seed-phrase
  # lobster harbor kingdom combine filter base suggest badge wood measure pelican future

  time.timeZone = "Europe/Vilnius";
  i18n.defaultLocale = "en_US.UTF-8";
}
