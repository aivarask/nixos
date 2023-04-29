_: {
  home.file.".xinitrc".text = builtins.readFile ./files/xinitrc;
  home.file.".wallpaper".source = ../images/wallpaper/abstract;
}
