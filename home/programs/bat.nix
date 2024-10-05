{ pkgs, ... }:
{
  home.sessionVariables.BAT_THEME = "gruvbox-dark";
  programs.bat = {
    enable = true;
    config = {
      # pager = "less -FR";
      style = "numbers,changes,header";
      map-syntax = [
        "*.postcss:CSS"
        "*.prisma:GraphQL"
        "*.mdx:Markdown"
        "flake.lock:JSON"
      ];
    };
    extraPackages = with pkgs.bat-extras; [
      batgrep
      batman
      batpipe
      batwatch
      # batdiff
      prettybat
    ];
  };
}
