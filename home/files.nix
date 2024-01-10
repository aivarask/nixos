{ ... }: {
  home = {
    file = {
      # ".config/glow/glow.yml" = builtins.readFile ./files/glow.yml;
      ".xinitrc".text = builtins.readFile ./files/xinitrc;
      ".wallpaper" = {
        source = ../images/wallpaper;
        recursive = false;
      };

      # TODO Finish using tilda (dropdown terminal)
      ".config/tilda/config_0".text = builtins.readFile ./files/tilda;
    };
  };
}
