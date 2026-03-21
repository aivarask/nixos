{
  pkgs,
  config,
  xdgconf,
  ...
}:
{
  programs.eza.enable = true;
  programs.eza.icons = "auto";
  programs.eza.enableZshIntegration = false;
}
