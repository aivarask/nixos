{pkgs, ...}: {
  # home.file.".icons/default".source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ";
  home.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 64;
    x11 = {
      enable = true;
      # defaultCursor = "left_ptr";
    };
    # gtk = {
    #   enable = true;
    # };
  };
}
