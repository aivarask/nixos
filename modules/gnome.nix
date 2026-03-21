{ pkgs, ... }:
{
  services.gnome.gnome-keyring.enable = true;
  environment.systemPackages = with pkgs; [
    # gst_all_1.gst-libav
    # gst_all_1.gst-plugins-bad
    # gst_all_1.gst-plugins-base
    # gst_all_1.gst-plugins-good
    # gst_all_1.gst-plugins-ugly
    # gst_all_1.gst-vaapi
    # gst_all_1.gstreamer

    grc
    # polkit-gnome
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
