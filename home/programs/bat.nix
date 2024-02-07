{ pkgs, ... }: {
  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.bat.enable
  home.sessionVariables = {
    BAT_THEME = "gruvbox-dark";
  };
  # home.shellAliases = { };
  programs.bat = {
    enable = true;
    config = {
      style = "numbers,changes,header";
      # pager = "less -FR";
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
      batdiff
      prettybat
    ];
  };
}
