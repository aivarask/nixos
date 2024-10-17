{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    # gtk3
    # gtk3-x11
    # layan-gtk-theme
    gruvbox-dark-gtk
    gruvbox-dark-icons-gtk
  ];

  home.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = lib.mkDefault 64;
    x11.enable = true;
    gtk.enable = true;
  };
  xdg.configFile = {
    "nicotine/config_def" = {
      source = ./files/nicotine;
      enable = true;
      recursive = true;
      onChange = ''
        cat /root/.config/nicotine/config_def > /root/.config/nicotine/config
      '';
    };
  };
}
