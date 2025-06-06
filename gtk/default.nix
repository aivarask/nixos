{
  hm =
    { pkgs, ... }:
    {
      gtk.enable = true;
      gtk.theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
      home.packages = with pkgs; [
        # gtk3
        # gtk3-x11
        gnome-themes-extra
        layan-gtk-theme
        # gruvbox-dark-gtk
        # gruvbox-dark-icons-gtk
      ];
    };
}
