{ pkgs, ... }:
{
  # https://wiki.nixos.org/wiki/Default_applications
  # ls /run/current-system/sw/share/applications # for global packages
  # ls /etc/profiles/per-user/$(id -n -u)/share/applications # for user packages
  #ls ~/.nix-profile/share/applications # for home-manager packages
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
      default = [ "gnome" ];
      "org.freedesktop.impl.portal.Screencast" = [ "gtk" ];
    };
  };
}
