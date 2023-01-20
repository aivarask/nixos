{ pkgs, ... }: {
  nixpkgs.config.permittedInsecurePackages = [
    # "qtwebkit-5.212.0-alpha4"
  ];
  services.xserver = {
    # https://nixos.wiki/wiki/Keyboard_Layout_Customization
    # https://wiki.archlinux.org/title/Xorg/Keyboard_configuration#Frequently_used_XKB_options
    # https://search.nixos.org/options
    enable = true;
    libinput.enable = true;
    layout = "us,lt";
    xkbVariant = "qwerty"; # localectl list-x11-keymap-variants
    xkbOptions = "grp:menu_toggle"; # localectl list-x11-keymap-options

    displayManager = {
      startx.enable = true;
      sessionCommands = ''
        xmessage \"Hello World!\" &\n
        imwheel -b45
      '';
      # displayManager.gdm.enable = true;
      # desktopManager.gnome.enable = true;

      # https://nixos.wiki/wiki/KDE
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
