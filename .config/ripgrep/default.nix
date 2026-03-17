{
  pkgs,
  osConfig,
  xdgconf,
  ...
}:
{

  xdg.configFile."ripgrep".source = osConfig.symlink "${xdgconf}/ripgrep";

}
