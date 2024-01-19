{ pkgs, ... }: {
  home.sessionVariables = {
    BAT_THEME = "gruvbox-dark";
  };
  home.shellAliases = {
    less = "batpipe"; # https://github.com/eth-p/bat-extras/blob/master/doc/batpipe.md
    bm = "batman"; # https://github.com/eth-p/bat-extras/blob/master/doc/batman.md
  };
  programs.bat = {
    enable = true;
    config = {
      style = "numbers,changes,header";
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
  };
}
