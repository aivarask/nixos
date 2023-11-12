{...}: {
  # manpages
  documentation = {
    dev.enable = false;
    doc.enable = true; # default true
    info.enable = true; # default true
    man = {
      enable = true;
      generateCaches = false;
      man-db = {
        enable = false;
      };
      mandoc = {
        enable = true;
      };
    };
    nixos = {};
  };
}
