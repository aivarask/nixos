{...}: {
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

      ".config/sql-language-server/.sqllsrc.json".text = builtins.readFile ./files/.sqllsrc.json;
      ".config/sql-language-server/.sqlintrc.json".text = builtins.readFile ./files/.sqlintrc.json;

      ".config/sqlite3/sqliterc".text = builtins.readFile ./files/sqliterc;
    };
  };
}
