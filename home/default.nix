{ pkgs, lib, inputs, config, include, ... }: {
  imports = [
    ./colors.nix
    ../vim
  ]
  ++ include ./programs
  ++ include ./services;

  programs.home-manager.enable = true;
  home.sessionVariables = {
    BROWSER = "firefox";
    MOZ_X11_EGL = "1";
    # SYSTEM = config.system.name;
  };

  home.stateVersion = "23.05";
  home = {
    file = {
      ".wallpaper" = { source = ../images/wallpaper; recursive = false; };
      ".config/tilda/config_0".text = builtins.readFile ./files/tilda;
      ".dwm-status.toml".text = builtins.readFile ./files/dwm-status_dell.toml + builtins.readFile ./files/dwm-status.toml;
      # ".dwm-status.toml".text = builtins.readFile ./files/dwm-status_pc.toml + builtins.readFile ./files/dwm-status.toml;
    };
  };
  xdg.configFile."nicotine/config_example" = {
    enable = true;
    source = ./files/nicotine_config;
  };
  # Dell
  home.pointerCursor = {
    # home.file.".icons/default".source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ";
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = lib.mkDefault 64;
    x11 = {
      enable = true;
      # defaultCursor = "left_ptr";
    };
    # gtk = {
    #   enable = true;
    # };
  };

}
