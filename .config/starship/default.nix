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
  xdg.configFile."starship/starship.toml".source =
    osConfig.symlink "${xdgconf}/starship/starship.toml";
  programs.starship.enable = true;
  programs.starship.enableBashIntegration = true;
  programs.starship.enableZshIntegration = true;
}
