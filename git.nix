{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Aivaras Kalesnykas";
    userEmail = "kalesnykas.aivaras@gmail.com";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      pull.rebase = true;
    };
    ignores = [
      "*.lock"
      "*.swp"
      ".direnv"
      "build"
      "node_modules"
      "package-lock.json"
      "result"
      "tags"
      "www"
    ];
  };
}
