{ pkgs, ... }:
{
  # services.desktopManager.gnome.enable = true;

  # services.gnome.gnome-remote-desktop.enable = true;
  # systemd.services.gnome-remote-desktop.wantedBy = [ "graphical.target" ]; # for starting the unit automatically at boot
  # networking.firewall.allowedTCPPorts = [ 3389 ];

  # services.gnome.gnome-keyring.enable = true;
  # security.pam.services.login.enableGnomeKeyring = true;

  # xdg.portal.extraPortals = [ pkgs.gnome-keyring ];

  environment.systemPackages = with pkgs; [
    # gst_all_1.gstreamer # https://wiki.nixos.org/wiki/GStreamer
    # seahorse
    # gnome-keyring
    gvfs
    thunar-volman
    gcr
    gparted
    gnome-disk-utility
    file-roller
    gnome-calculator
    gnome-network-displays
    gnome-system-monitor
    gnome-themes-extra
    gnome-tweaks
    dconf-editor
    lxappearance

    rtfm

    # https://nwg-piotr.github.io/nwg-shell/
    nwg-hello
    nwg-panel
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
