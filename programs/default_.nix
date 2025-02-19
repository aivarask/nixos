{ pkgs, ... }:
{
  home.packages = with pkgs; [
    chromedriver
    vimpager
  ];
  programs.kitty = {
    enable = true;
  };
  programs.eza = {
    enable = true;
    icons = "auto";
    enableZshIntegration = false;
  };
  programs.nushell.enable = true;
  programs.zathura.enable = true;
}
