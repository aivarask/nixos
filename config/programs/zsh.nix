{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    spaceship-prompt
  ];
  programs.zsh.enable = true;
}
