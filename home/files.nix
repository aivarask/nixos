_: {
  home.file.".xinitrc".text = builtins.readFile ./files/xinitrc;
  home.file.".wallpaper/super".source = ../images/wallpaper/super;
  home.file.".config/tilda/config_0".text = builtins.readFile ./files/tilda;
}
