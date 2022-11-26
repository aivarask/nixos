{ config, pkgs, ... }: {
  nixpkgs.config.permittedInsecurePackages = [
    "qtwebkit-5.212.0-alpha4"
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
    imwheel = {
      enable = true;
      rules = {
        # imwheel -d --debug --kill
        # ".*" = ''
        "^(vieb|firefox|brave-browser|google-chrome-stable|google-chrome|telegram-desktop)$" = ''
          None, Up, Button4, 4
          None, Down, Button5, 4
          Shift_L,   Up,   Shift_L|Button4, 4
          Shift_L,   Down, Shift_L|Button5, 4
          Control_L, Up,   Control_L|Button4
          Control_L, Down, Control_L|Button5
        '';
      };
      # extraOptions = [ "--buttons=45" ];
    };
    displayManager.startx.enable = true;
    displayManager.sessionCommands = ''
      xmessage \"Hello World!\" &\n
      imwheel -b45
    '';
    # displayManager.gdm.enable = true;
    # desktopManager.gnome.enable = true;

    # https://nixos.wiki/wiki/KDE
    displayManager.sddm.enable = false;
    desktopManager.plasma5.enable = true;
    desktopManager.plasma5.excludePackages = with pkgs.libsForQt5; [
      elisa
      gwenview
      okular
      oxygen
      khelpcenter
      konsole
      plasma-browser-integration
      print-manager
      # qtwebkit
    ];



    # displayManager.autoLogin = {
    #   enable = true;
    #   user = "ak";
    # };
  };
}

