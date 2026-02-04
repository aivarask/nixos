{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    (
      { pkgs, ... }:
      {
        programs.uwsm.enable = true;
        programs.uwsm.waylandCompositors.sway.binPath = "${pkgs.sway}/bin/sway";
        programs.uwsm.waylandCompositors.sway.prettyName = "mysway";
        environment.systemPackages = with pkgs; [
          sway
          swaybg
          swayidle
          swaylock
          waybar
          foot
          grim
          slurp
          wl-clipboard
          mako
          kanshi
          gammastep
          playerctl
          xdg-desktop-portal-wlr
          pipewire
          wireplumber
          pavucontrol
          # polkit-gnome

        ];
        environment.variables = {
          WLR_DRM_NO_MODIFIERS = 1;
          WLR_RENDERER = "vulkan";
          XDG_CURRENT_DESKTOP = "sway";
          MOZ_ENABLE_WAYLAND = 1;
          QT_QPA_PLATFORM = "wayland";
          CLUTTER_BACKEND = "wayland";
          SDL_VIDEODRIVER = "wayland";

        };
      }
    )
  ];

  # services.xserver.exportConfiguration = true;
  services.gnome.gnome-keyring.enable = true;
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
