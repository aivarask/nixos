{
  pkgs,
  config,
  xdgconf,
  ...
}:
{
  home.packages = with pkgs; [
    nicotine-plus
  ];
  xdg.configFile."nicotine" = {
    source = config.lib.file.mkOutOfStoreSymlink "${xdgconf}/nicotine";
    enable = true;
    force = true;
    recursive = true;
  };

}
