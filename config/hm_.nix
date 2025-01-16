{
  pkgs,
  lib,
  osConfig,
  ...
}:
{
  home.packages = with pkgs; [
    # gtk3
    # gtk3-x11
    # layan-gtk-theme
    gruvbox-dark-gtk
    gruvbox-dark-icons-gtk
  ];
  home.sessionVariables.GDK_SCALE = 2; # nicotine pwvucontrol inkscape ...
  home.sessionVariables.GDK_DPI_SCALE =
    {
      dell = "0.35";
      pc = "0.5";
    }
    ."${osConfig.networking.hostName}"; # firefox
  home.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = lib.mkDefault 64;
    x11.enable = true;
    gtk.enable = true;
  };
}
