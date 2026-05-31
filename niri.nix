{ pkgs, ... }:
{
  programs.niri.enable = true;
  environment.systemPackages = with pkgs; [
    xwayland-satellite
    xwayland-run
    udiskie
    wluma
    hyprpaper
    cliphist
    rclone
  ];
}
