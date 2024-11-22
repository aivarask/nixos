{ pkgs, ... }:
{
  home.packages = with pkgs; [
    git
    git-lfs
    gh
    git-crypt
    pre-commit
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
      ".pytest_cache/"
      "__pycache__"
      ".zig-cache/"
    ];
    userName = "Aivaras Kalesnykas";
    userEmail = "kalesnykas.aivaras@gmail.com";
  };
}
