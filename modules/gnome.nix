{ pkgs, ... }:
{
  services.desktopManager.gnome.enable = true;

  services.gnome.gnome-remote-desktop.enable = true;
  systemd.services.gnome-remote-desktop.wantedBy = [ "graphical.target" ]; # for starting the unit automatically at boot
  networking.firewall.allowedTCPPorts = [ 3389 ];

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  xdg.portal.extraPortals = [ pkgs.gnome-keyring ];

  environment.systemPackages = with pkgs; [
    # gst_all_1.gstreamer # https://wiki.nixos.org/wiki/GStreamer
    seahorse
    gnome-keyring
    gcr
    gparted
    gnome-disk-utility
    gnome-calculator
    gnome-network-displays
    gnome-system-monitor
    gnome-themes-extra
    gnome-tweaks
    dconf-editor
    lxappearance
    nwg-panel
    nwg-dock
    nwg-icon-picker
    nwg-menu
    nwg-drawer
    nwg-clipman
    nwg-dock
    nwg-displays
  ];
}
