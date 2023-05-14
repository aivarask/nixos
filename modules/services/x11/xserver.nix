{lib, ...}: {
  services.xserver = {
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
  };
}
