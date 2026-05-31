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

  services.keyd.enable = true;
  services.keyd.keyboards."default".settings = {
    main = {
      # meta = {
      #   o = "🥰";
      # };
      # capslock = "overload(meta, esc)";
      # esc = "capslock";
    };
  };
  environment.etc."keyd/test.conf".source = "/etc/nixos/keyd/test.conf";
  # https://github.com/rvaiya/keyd/issues/723
  environment.etc."libinput/local-overrides.quirks".text = ''
    [Serial Keyboards]
    MatchUdevType=keyboard
    MatchName=keyd virtual keyboard
    AttrKeyboardIntegration=internal
  '';
  programs.ydotool.enable = true;
  programs.sway.enable = true;
  programs.sway.package = pkgs.swayfx;
  programs.sway.wrapperFeatures.gtk = true;

  programs.uwsm.enable = true;
  programs.uwsm.waylandCompositors.sway.binPath = "/run/current-system/sw/bin/sway";
  programs.uwsm.waylandCompositors.sway.extraArgs = [
    "-V"
  ];
  programs.uwsm.waylandCompositors.sway.prettyName = "swayfx";
  programs.uwsm.waylandCompositors.sway.comment = "swayfx verbose";

  programs.dconf.enable = true;

  environment.variables.GST_PLUGIN_PATH = "/run/current-system/sw/lib/gstreamer-1.0/";
  environment.systemPackages = with pkgs; [
    clipman
    mcat
    keyd
    wshowkeys
    libinput
    # sway-overfocus
    showmethekey
    fuzzel
    x11perf
    waypipe
    ydotool
    hyprmagnifier
    bemoji
    catt
    eww
    flameshot
    foot
    gammastep
    glib-networking
    grim
    ifwifi
    kanshi
    localsend
    # mako
    miraclecast
    papirus-icon-theme
    pavucontrol
    pipewire
    playerctl
    python3
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
    # sway-easyfocus
    sway-launcher-desktop
    sway-new-workspace
    sway-scratch
    swaybg
    swayidle
    swaylock
    swayr
    waybar
    wayvnc
    wdisplays
    wev
    wtype
    evtest
    # wireplumber
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
