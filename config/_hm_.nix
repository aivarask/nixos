{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    # gtk3
    # gtk3-x11
    # layan-gtk-theme
    gruvbox-dark-gtk
    gruvbox-dark-icons-gtk
  ];
  home.sessionVariables.GDK_SCALE = 2; # @type integer. nicotine pwvucontrol inkscape ...
  home.sessionVariables.GDK_DPI_SCALE = 0.75; # firefox
  home.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = lib.mkDefault 64;
    x11.enable = true;
    gtk.enable = true;
  };
}
