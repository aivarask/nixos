{pkgs, ...}: {
  services.xserver = {
    enable = true;
    displayManager = {
      startx.enable = true;
      sddm.enable = false;
    };
    desktopManager.plasma5.enable = true;
    windowManager = {
      dwm = {
        enable = true;
      };
    };
    autoRepeatDelay = 200;
    autoRepeatInterval = 50;
    enableCtrlAltBackspace = true;
    layout = "us,lt";
    upscaleDefaultCursor = true;
    xkbOptions = "grp:menu_toggle"; # localectl list-x11-keymap-options
    xkbVariant = "qwerty"; # localectl list-x11-keymap-variants
  };
}
