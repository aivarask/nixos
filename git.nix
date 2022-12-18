{ config, pkgs, ... }:
# https://github.com/nix-community/home-manager/blob/master/modules/programs/git.nix
{
  programs.git = {
    enable = true;
    userName = "Aivaras Kalesnykas";
    userEmail = "kalesnykas.aivaras@gmail.com";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      pull.rebase = false;
      core = {
        hookspath = ".githooks";
      };
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
      "packages"
    ];
  };
}
