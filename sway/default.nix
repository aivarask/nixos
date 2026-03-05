{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [ ];
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
    # polkit-gnome
    # sway-overfocus
    bemoji
    catt
    dconf-editor
    eww
    flameshot
    foot
    gammastep
    glib-networking
    gnome-calculator
    gnome-network-displays
    gnome-system-monitor
    gnome-themes-extra
    gnome-tweaks
    grim
    gst_all_1.gst-libav
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-vaapi
    gst_all_1.gstreamer
    i3
    ifwifi
    kanshi
    localsend
    lxappearance
    mako
    miraclecast
    oranchelo-icon-theme
    papirus-icon-theme
    pavucontrol
    pipewire
    playerctl
    python3
    qtscrcpy
    rofi
    scrcpy
    slurp

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
    wlr-which-key
    wlr-randr
    wttrbar
    xcursor-pro
    xdg-desktop-portal-wlr
    xkeyboard-config
    xkbcomp
    setxkbmap
    # https://github.com/swaywm/sway/wiki/Useful-add-ons-for-sway#bar-content-generators
    nwg-panel
    nwg-dock
    nwg-icon-picker
    nwg-menu
    nwg-drawer
    nwg-clipman
    nwg-dock
    nwg-displays
    yt-dlp

  ];
}
