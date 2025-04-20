{ ... }:
{
  xdg.configFile."sqlite3/sqliterc".source =           config.lib.file.mkOutOfStoreSymlink
    "/etc/nixos/sql/sqliterc";
  };
}
