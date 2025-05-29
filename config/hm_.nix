{
  pkgs,
  lib,
  osConfig,
  ...
}:
{
  dconf = {
    enable = false;
    settings = {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      # "org/gnome/desktop/background" = {
      #   picture-uri-dark = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
      # };
    };
  };
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };
  home.packages = with pkgs; [
    # gtk3
    # gtk3-x11
    # layan-gtk-theme
    gruvbox-dark-gtk
    gruvbox-dark-icons-gtk
  ];
  home.sessionVariables.GDK_SCALE = 2; # nicotine pwvucontrol inkscape ...
  # home.sessionVariables.GDK_DPI_SCALE =
  #   {
  #     dell = "0.35";
  #     pc = "0.5";
  #   }
  #   ."${osConfig.networking.hostName}"; # firefox
  home.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = lib.mkDefault 64;
    x11.enable = true;
    gtk.enable = true;
  };
}
