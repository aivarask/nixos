{
  SELF,
  config,
  pkgs,
  lib,
  ...
}:
{
  home.file.".xinitrc".source = config.lib.file.mkOutOfStoreSymlink "${SELF}/x11/xinitrc";
  home.file.".Xresources_extra".source =
    config.lib.file.mkOutOfStoreSymlink "${SELF}/x11/.Xresources_extra";
  xresources.extraConfig = ''#include ".Xresources_extra"'';
  home.pointerCursor.x11.enable = true;
  home.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = lib.mkDefault 64;
    gtk.enable = true;
  };
}
