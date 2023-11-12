{pkgs, ...}: {
  programs.bat = {
    enable = true;
    config = {
      style = "numbers,changes,header";
      # theme = "TwoDark";
      # theme = "Dracula";
      # theme = "Monokai Extended";
      pager = "less -FR";
      map-syntax = [
        "*.postcss:CSS"
        "*.prisma:GraphQL"
        "*.mdx:Markdown"
      ];
    };
    extraPackages = with pkgs.bat-extras; [
      batgrep
      batman
      batpipe
      batwatch
      batdiff
      prettybat
    ];
    themes = {
      dracula = {
        src = pkgs.fetchFromGitHub {
          owner = "dracula";
          repo = "sublime"; # Bat uses sublime syntax for its themes
          rev = "26c57ec282abcaa76e57e055f38432bd827ac34e";
          sha256 = "019hfl4zbn4vm4154hh3bwk6hm7bdxbr1hdww83nabxwjn99ndhv";
        };
        file = "Dracula.tmTheme";
      };
    };
  };
}
