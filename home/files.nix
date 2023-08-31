_: {
  home.file.".xinitrc".text = builtins.readFile ./files/xinitrc;
  home.file.".wallpaper" = {
    source = ../images/wallpaper;
    recursive = false;
  };

  # TODO Finish using tilda (dropdown terminal)
  home.file.".config/tilda/config_0".text = builtins.readFile ./files/tilda;
}
