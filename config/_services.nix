# vim:foldlevel=4
{
  pkgs,
  lib,
  config,
  ...
}:
{
  services.caddy = {
    enable = false;
  };

  services.locate = {
    enable = true;
  };

}
