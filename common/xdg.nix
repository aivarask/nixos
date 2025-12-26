{ pkgs, ... }:
{
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    xdg-desktop-portal-wlr
    # xdg-desktop-portal-hyprland
  ];
  xdg.portal.xdgOpenUsePortal = true;
  xdg.portal.config = {
    common = {
      default = [ "gtk" ];
      "org.freedesktop.impl.portal.Screencast" = [ "hyprland" ];
    };
  };
}
