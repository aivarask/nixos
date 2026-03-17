{
  pkgs,
  xdgconf,
  osConfig,
  ...
}:
{
  programs.ncmpcpp.enable = true;
  xdg.configFile."ncmpcpp/config" = {
    source = osConfig.symlink "${xdgconf}/ncmpcpp/config";
    enable = true;
    force = true;
  };
  xdg.configFile."ncmpcpp/bindings" = {
    source = osConfig.symlink "${xdgconf}/ncmpcpp/bindings";
    enable = true;
    force = true;
  };

}
