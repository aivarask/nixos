{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    spaceship-prompt
    zsh
  ];
  programs.zsh.enable = true;
}
