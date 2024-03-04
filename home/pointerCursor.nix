{ pkgs, lib, ... }: {
  home.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = lib.mkDefault 64;
    x11.enable = true;
    gtk.enable = false;
  };
}
