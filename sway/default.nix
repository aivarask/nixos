{
  config,
  pkgs,
  lib,
  ...
}:
{
  # services.xserver.exportConfiguration = true;
  # services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  programs.sway.enable = true;
  programs.sway.wrapperFeatures.gtk = true;
  programs.uwsm.enable = true;
  programs.uwsm.waylandCompositors.sway.binPath = "${pkgs.sway}/bin/sway";
  programs.uwsm.waylandCompositors.sway.prettyName = "mysway";
  # programs.uwsm.waylandCompositors.hyprland.prettyName = "Hyprland";
  # programs.hyprland.enable = true;
  # programs.hyprland.withUWSM = true;

  environment.variables.GST_PLUGIN_PATH = "/run/current-system/sw/lib/gstreamer-1.0/";
  environment.systemPackages = with pkgs; [
    flameshot
    wayvnc
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
    gst_all_1.gst-vaapi
    glib-networking
    gnome-network-displays
    miraclecast
    gnome-system-monitor
    bemoji
    ifwifi
    catt
    scrcpy
    qtscrcpy
    localsend
    eww
    uwsm
    sway
    sway-easyfocus
    sway-launcher-desktop
    sway-contrib.inactive-windows-transparency
    sway-contrib.grimshot
    # sway-overfocus
    sway-new-workspace
    sway-scratch
    wdisplays
    i3
    wev
    wlr-which-key
    grim # screenshot functionality
    slurp # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    mako # notification system developed by swaywm maintainer
    swaynotificationcenter
    gammastep
    waybar
    wttrbar
    lxappearance
    dconf-editor
    xkeyboard-config
    xorg.xkbcomp
    xcursor-pro
    mojave-gtk-theme
    oranchelo-icon-theme
    gnome-themes-extra
    jasper-gtk-theme
    fluent-gtk-theme
    fluent-icon-theme
    papirus-icon-theme
  ];

}
