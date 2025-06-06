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
}
