_: {
  home.file.".xinitrc".text = builtins.readFile ./files/xinitrc;
  home.file.".wallpaper" = {
    source = ../images/wallpaper;
    recursive = false;
  };

  home.file.".config/tilda/config_0".text = builtins.readFile ./files/tilda;
}
