{
  lib,
  config,
  pkgs,
  ...
}:
{
  environment.systemPackages =
    with pkgs;
    [
      xcompmgr
      xdotool
      xsel
      xclip
      sxiv
      numlockx
      xautomation
      xbindkeys
      xvkbd
      wmctrl
      xpra # https://github.com/Xpra-org/xpra/blob/master/docs/Usage/README.md
    ]
    ++ (with pkgs.xorg; [
      xorgproto
      xbacklight
      xorgserver
      xdpyinfo
      xev
      xmodmap
      xmessage
      transset
      xwininfo
      xwd
    ]);

  environment.variables.XINITRC = "/etc/nixos/services/xinitrc";
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    # displayManager.xpra.enable = true;
    windowManager.awesome.enable = lib.mkDefault false;
    windowManager.dwm.enable = lib.mkDefault true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 50;
    enableCtrlAltBackspace = true;
    enableTCP = true;
    upscaleDefaultCursor = true;
    config = ''

      		'';
    xkb = {
      layout = "us,lt";
      options = "grp:menu_toggle"; # localectl list-x11-keymap-options
      variant = "qwerty"; # localectl list-x11-keymap-variants
    };
    tty = null;
    # https://wiki.archlinux.org/title/Multihead
    xrandrHeads = [ ];
    imwheel = {
      enable = true;
      rules = {
        "^(telegram-desktop|chromium|brave|firefox).*" = ''
          None, Up, Button4, 2
          None, Down, Button5, 2
          Shift_L,   Up,   Shift_L|Button4, 2
          Shift_L,   Down, Shift_L|Button5, 2
          Control_L, Up,   Control_L|Button4
          Control_L, Down, Control_L|Button5
        '';
      };
    };
    # xdpyinfo | grep -E 'dimensions|resolution'
    # https://pixelcalculator.com/en
    # http://www.screen-size.info/
    # Dell XPS 7590 		15.6" 3840x2160 345x194 = 283 dpi
    # Dell P2715Q 			27" 3840x2160 597x336 	= 163 dpi
    # TOSHIBA 49U6763DG 49" 3840x2160 1085x610	= 90 dpi
    dpi = lib.mkDefault null;
  };

}
