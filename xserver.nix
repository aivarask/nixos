{ pkgs, ... }: {
  nixpkgs.config.permittedInsecurePackages = [
    # "qtwebkit-5.212.0-alpha4"
  ];
  services.xserver = {
    enable = true;
    layout = "us,lt";
    xkbVariant = "qwerty"; # localectl list-x11-keymap-variants
    xkbOptions = "grp:menu_toggle"; # localectl list-x11-keymap-options
    displayManager = {
      startx.enable = true;
      sddm.enable = false;
    };
    desktopManager.plasma5.enable = true;
  };
  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    elisa
    gwenview
    okular
    oxygen
    khelpcenter
    konsole
    plasma-browser-integration
    print-manager
    qtwebkit
  ];
}
