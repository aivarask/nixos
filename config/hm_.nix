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
}
