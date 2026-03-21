{
  pkgs,
  config,
  osConfig,
  xdgconf,
  lib,
  ...
}:
{
  home.sessionVariables.STARSHIP_CONFIG = lib.mkForce "${config.xdg.configHome}/starship/starship.toml";
  xdg.configFile."starship".source = osConfig.symlink "${xdgconf}/starship";
  programs.starship.enable = true;
  programs.starship.enableBashIntegration = true;
  programs.starship.enableZshIntegration = true;
}
