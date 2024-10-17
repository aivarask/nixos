{ pkgs, ... }:
{
  home.shellAliases.lg = "lazygit";
  home.packages = with pkgs; [
    git
    git-lfs
    gh
    git-crypt
    pre-commit
    lazygit
  ];
  programs.git = {
    delta.enable = false;
    lfs.enable = true;
    enable = true;
    aliases = {
      ci = "commit";
      pr = "pull --rebase";
    };
    extraConfig = {
      core.hookspath = ".githooks";
      init.defaultBranch = "main";
      pull.rebase = true;
    };
    ignores = [
      "*.lock"
      "!flake.lock"
      "*lock.json"
      "*lock.yaml"
      "tags"
      "node_modules/"
      "vendor/"
      "CMakeFiles/"
      "Session.vim"
    ];
    userName = "Aivaras Kalesnykas";
    userEmail = "kalesnykas.aivaras@gmail.com";
  };
}
