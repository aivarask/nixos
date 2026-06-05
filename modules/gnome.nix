{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    # gst_all_1.gstreamer # https://wiki.nixos.org/wiki/GStreamer
    # seahorse
    # gnome-keyring
    gvfs
    gcr
    gparted
    gnome-disk-utility
    file-roller
    gnome-calculator
    gnome-network-displays
    gnome-system-monitor
    gnome-themes-extra
    orchis-theme
    gnome-tweaks
    dconf-editor

    # https://nwg-piotr.github.io/nwg-shell/
    nwg-hello
    nwg-drawer
    nwg-dock
    nwg-menu
    swaynotificationcenter
    gtklock
    nwg-look
    nwg-displays

    # utils
    swappy
    nwg-bar
    nwg-clipman
    nwg-icon-picker
    nwg-wrapper
    autotiling # autotiling-rs

    # launchers
    ulauncher
  ];
}
