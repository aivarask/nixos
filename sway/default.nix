{
  config,
  pkgs,
  lib,
  ...
}:
{
  environment.variables.WLR_DRM_NO_MODIFIERS = 1;
  environment.variables.WLR_RENDERER = "vulkan";
  environment.variables.XDG_CURRENT_DESKTOP = "sway";
  environment.variables.MOZ_ENABLE_WAYLAND = 1;
  environment.variables.QT_QPA_PLATFORM = "wayland";
  environment.variables.CLUTTER_BACKEND = "wayland";
  environment.variables.SDL_VIDEODRIVER = "wayland";
  programs.sway.enable = true;
  programs.sway.package = pkgs.swayfx;
  programs.sway.wrapperFeatures.gtk = true;
  programs.uwsm.enable = true;
  programs.uwsm.waylandCompositors.sway.binPath = "${pkgs.swayfx}/bin/sway";
  programs.uwsm.waylandCompositors.sway.prettyName = "mysway";
  programs.dconf.enable = true;

  environment.variables.GST_PLUGIN_PATH = "/run/current-system/sw/lib/gstreamer-1.0/";
  environment.systemPackages = with pkgs; [
    # sway-overfocus
    bemoji
    catt
    eww
    flameshot
    foot
    gammastep
    glib-networking
    grim
    gst_all_1.gst-libav
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-vaapi
    gst_all_1.gstreamer
    ifwifi
    kanshi
    localsend
    mako
    miraclecast
    papirus-icon-theme
    pavucontrol
    pipewire
    playerctl
    python3
    qtscrcpy
    rofi
    scrcpy
    slurp
    kdotool

    # internet speed
    ookla-speedtest
    speedtest-cli
    iperf3
    traceroute

    # sway
    sway-contrib.grimshot
    sway-contrib.inactive-windows-transparency
    sway-easyfocus
    sway-launcher-desktop
    sway-new-workspace
    sway-scratch
    swaybg
    swayidle
    swaylock
    swaynotificationcenter
    swayr
    uwsm
    waybar
    wayvnc
    wdisplays
    wev
    wtype
    evtest
    wireplumber
    wl-clipboard
    wlr-randr
    wttrbar
    xcursor-pro
    xdg-utils # https://www.freedesktop.org/wiki/Software/xdg-utils/
    xdg-terminal-exec
    xdg-user-dirs
    xdg-user-dirs-gtk
    # xdg-desktop-portal-wlr
    xkeyboard-config
    xkbcomp
    xmodmap
    setxkbmap
    # https://github.com/swaywm/sway/wiki/Useful-add-ons-for-sway#bar-content-generators

  ];
}
