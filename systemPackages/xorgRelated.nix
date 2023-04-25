{pkgs, ...}: {
  environment.systemPackages = with pkgs;
    [
      xcompmgr
      xdotool
      xsel
      xclip
      sxiv
      unclutter-xfixes
      numlockx
      xautomation
      xbindkeys
    ]
    ++ (with pkgs.xorg; [
      # https://nixos.wiki/wiki/Using_X_without_a_Display_Manager
      xbacklight
      xorgserver
      xf86inputevdev
      xf86inputsynaptics
      xf86inputlibinput
      libX11
      libXrender
      xdpyinfo
      xev
      xmodmap
      xmessage
      transset
    ]);
}
