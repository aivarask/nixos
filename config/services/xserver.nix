{ lib, pkgs, ... }: {

  services.xserver = {
    displayManager.sddm.enable = lib.mkDefault false;
    windowManager.awesome.enable = lib.mkDefault false;
    windowManager.dwm.enable = lib.mkDefault true;
    displayManager.startx.enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 50;
    dpi = lib.mkDefault 144;
    enable = true;
    enableCtrlAltBackspace = true;
    enableTCP = true;
    layout = "us,lt";
    upscaleDefaultCursor = true;
    xkbOptions = "grp:menu_toggle"; # localectl list-x11-keymap-options
    xkbVariant = "qwerty"; # localectl list-x11-keymap-variants
    tty = null;
    # LINKS:
    # https://wiki.archlinux.org/title/Multihead
    xrandrHeads = [ ];
  };
  services.xserver.imwheel = {
    enable = lib.mkDefault true;
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

}
