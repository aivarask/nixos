{ ... }:
{
  xdg.configFile."sqlite3/sqliterc" = {
    # https://sqlite.org/cli.html#changing_output_formats
    text = ''
      .mode list
    '';
  };
}
