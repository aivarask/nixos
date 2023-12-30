{pkgs, ...}: {
  programs.zsh.enable = true;
  environment.profiles = [
    "${pkgs.zsh-completions}"
  ];
}
