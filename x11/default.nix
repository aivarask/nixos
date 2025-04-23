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
      read-edid
    ]
    ++ (with pkgs.xorg; [
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
  # https://github.com/phillipberndt/autorandr
  services.autorandr.enable = true;
  services.autorandr.profiles = {
    "work" = {
      fingerprint = {
        eDP1 = "00ffffffffffff004d10b91400000000
		161d0104a52213780ed436aa5435bf25
		0c545600000001010101010101010101
		0101010101014dd000a0f0703e803020
		350058c2100000180000000000000000
		00000000000000000000000000fe004e
		35563843844c51313536443100000000
		0002410332011200000b010a20200056";
        DP-3 = "00ffffffffffff0010acce404c323841
		301a0103803c2278eaee95a3544c9926
		0f5054a54b00d100d1c0b300a9408180
		8100714f010108e80030f2705a80b058
		8a0055502100001e000000ff00563438
		57323642534138324c0a000000fc0044
		454c4c205032373135510a20000000fd
		001d4b1f8c3c000a2020202020200177
		02033bf15561605f5e5d101f20051404
		1312110302161507060123091f078301
		00006d030c001000003c200060030201
		67d85dc40178c800e20f0308e80030f2
		705a80b0588a0055502100001e047400
		30f2705a80b0588a0055502100001e02
		3a801871382d40582c45005550210000
		1e000000000000000000000000000043";
      };
      config = {
        eDP1.enable = true;
        DP-3 = {
          enable = true;
          crtc = 0;
          primary = true;
          position = "0x0";
          mode = "3840x2160";
          gamma = "1.0:0.909:0.833";
          rate = "60.00";
          # rotate = "left";
          dpi = 192;
        };
      };
      # hooks.postswitch = readFile ./work-postswitch.sh;
    };
  };

  services.libinput.mouse.accelSpeed = "+0.5";
  services.libinput.touchpad.naturalScrolling = true;
  services.libinput.touchpad.accelSpeed = "+0.5";
  services.xserver.enable = true;
  services.xserver.config = '''';
  services.xserver.displayManager.xpra.enable = false;
  services.xserver.windowManager.awesome.enable = lib.mkDefault false;
  services.xserver.windowManager.dwm.enable = lib.mkDefault true;
  services.xserver.autoRepeatDelay = 200;
  services.xserver.autoRepeatInterval = 50;
  services.xserver.enableCtrlAltBackspace = true;
  services.xserver.enableTCP = true;
  services.xserver.upscaleDefaultCursor = true;
  services.xserver.xkb.model = "pc104";
  services.xserver.xkb.layout = "us,lt";
  services.xserver.xkb.options = "grp:menu_toggle"; # localectl list-x11-keymap-options
  # services.xserver.xkb.variant = "qwerty"; # localectl list-x11-keymap-variants
  services.xserver.xrandrHeads = [
    # https://wiki.archlinux.org/title/Multihead
    # xdpyinfo | grep -E 'dimensions|resolution'
    # https://pixelcalculator.com/en
    # http://www.screen-size.info/
    # Dell XPS 7590 		15.6" 3840x2160 345x194 = 283 dpi
    # Dell P2715Q 			27" 3840x2160 597x336 	= 163 dpi
    # TOSHIBA 49U6763DG 49" 3840x2160 1085x610	= 90 dpi
  ];
  services.xserver.dpi = lib.mkDefault null;
  services.xserver.tty = null;
  services.xserver.displayManager.startx.enable = true;

  services.xserver.displayManager.startx.generateScript = false;
  services.xserver.imwheel.enable = true;
  services.xserver.imwheel.rules = {
    "^(telegram-desktop|chromium|brave|firefox).*" = ''
      None, Up, Button4, 2
      None, Down, Button5, 2
      Shift_L,   Up,   Shift_L|Button4, 2
      Shift_L,   Down, Shift_L|Button5, 2
      Control_L, Up,   Control_L|Button4
      Control_L, Down, Control_L|Button5
    '';
  };
}
