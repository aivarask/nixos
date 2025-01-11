{ pkgs, ... }:
{
  programs.bat = {
    enable = true;
    config = {
      theme = "gruvbox-dark";
      pager = "less -R";
      style = "numbers,changes,header";
      map-syntax = [
        "bashrc:Bourne Again Shell (bash)"
        "zshrc:Bourne Again Shell (bash)"
        "zshenv:Bourne Again Shell (bash)"
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
      batdiff
      prettybat
    ];
  };
}
