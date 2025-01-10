{ lib, config, ... }:
{
  environment.variables.XINITRC = "/etc/nixos/services/xinitrc";
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
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
    # 15.6" 3840x2160 345x194
    # 27" 3840x2160 597x336
    dpi =
      {
        dell = 282;
        # pc = 163;
        pc = builtins.ceil (90 * 2.5);
      }
      ."${config.networking.hostName}" or 144;
  };

}
