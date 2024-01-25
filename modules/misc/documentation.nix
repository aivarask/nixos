{ pkgs, ... }: {
  environment.variables = {
    MANPAGER = "less -R --use-color -Dd+r -Du+b";
    MANROFFOPT = "-P -c";
  };
  environment.systemPackages = with pkgs; [
    man-pages
    man-pages-posix
    groff
  ];
  documentation = {
    enable = true;
    dev.enable = true;
    doc.enable = true;
    info.enable = true;
    man = {
      enable = true;
      generateCaches = true;
      man-db = {
        enable = true;
      };
      mandoc = {
        enable = false;
      };
    };
  };
}
