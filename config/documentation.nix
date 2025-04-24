{ pkgs, ... }:
{
  environment.variables.MANPAGER = "less -R --use-color -Dd+r -Du+b";
  environment.variables.MANROFFOPT = "-P -c";
  environment.systemPackages = with pkgs; [
    man-pages
    man-pages-posix
    groff
    cht-sh
    tldr
    manix
  ];
  documentation = {
    enable = true;
    dev.enable = true;
    doc.enable = true;
    info.enable = true;
    nixos = {
      enable = true;
      # includeAllModules = true;
    };
    man = {
      enable = true;
      generateCaches = true;
      man-db = {
        enable = true;
      };
      mandoc = {
        enable = false;
        settings.manpath = [ "/run/current-system/sw/share/man" ];
      };
    };
  };
}
