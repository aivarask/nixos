# https://nixos.wiki/wiki/Man_pages
{pkgs, ...}: {
  environment.systemPackages = [pkgs.man-pages pkgs.man-pages-posix];
  documentation = {
    nixos.enable = true;
    nixos.includeAllModules = true;

    enable = true;
    dev.enable = true;
    doc.enable = true;
    info.enable = true;
    man = {
      enable = true;
      generateCaches = true;
      man-db = {
        enable = false;
      };
      mandoc = {
        enable = true;
      };
    };
  };
}
