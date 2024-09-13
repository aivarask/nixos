{ ... }:
{
  programs.git.delta = {
    enable = false;
  };
  programs.git = {
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
    ];
    userName = "Aivaras Kalesnykas";
    userEmail = "kalesnykas.aivaras@gmail.com";
  };
}
