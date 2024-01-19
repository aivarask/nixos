# https://nixos.wiki/wiki/Man_pages
# https://wiki.archlinux.org/title/Man_page
{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    man-pages
    man-pages-posix
    # nixos-option
    groff
  ];
  environment.variables = {
    # Escape char issue
    # MANPAGER = "sh -c 'col -bx | bat -l man -p'";
  };

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
