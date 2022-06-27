{ config, pkgs, ... }:
{
  programs.bat = {
    enable = true;
    config = {
      style = "numbers,changes,header";
      # theme = "TwoDark";
      # theme = "Monokai Extended";
      pager = "less -FR";
      map-syntax = [
        "*.mdx:Markdown"
        "*.nimble:Nim"
        "*.prisma:GraphQL"
      ];

    };
  };
}
